package DBIx::Class::Inflator::Storable;

=head1 NAME

DBIx::Class::Inflator::Storable - Inflate and deflate columns in Storable format

=cut

use Storable qw//;

use strict;
use warnings;
use Carp;

our $VERSION = '0.01';


sub register_column {
    my ($self, $column, $info, @rest) = @_;
    $self->next::method($column, $info, @rest);

    return unless defined $info->{'is_storable'};

    my $freezer;
    if (defined $info->{'size'}){
       $freezer = get_bounded_column_freezer($info->{'size'});
    } else {
       $freezer = \&unbounded_freezer;
    }

    $self->inflate_column(
        $column => {
            inflate => sub {
	        my $value = shift;
		# Storable returns undef if the datastructure couldn't be thawed.
		# Other deserializers throw exceptions, so we'll do the same.
		# If the column had a NULL value, then we return it (don't want to die)
	        return undef if (not defined $value);
                my $s = Storable::thaw($value);
		croak "Storable couldn't thaw the value" if (not defined $s);
		return $s;
            },
            deflate => $freezer,
        }
    );
};


sub get_bounded_column_freezer {
   my ($size) = @_;
   return sub {
     my $s = Storable::nfreeze(shift);
     croak "serialization too big" if (length($s) > $size);
     return $s;
   };
}

sub unbounded_freezer {
   return Storable::nfreeze(shift);
}

1;
