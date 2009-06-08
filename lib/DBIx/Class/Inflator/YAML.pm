package DBIx::Class::Inflator::YAML;

=head1 NAME

DBIx::Class::Inflator::YAML - Inflate and deflate columns in YAML format

=cut

use YAML;

use strict;
use warnings;
use Carp;

our $VERSION = '0.01';


sub register_column {
    my ($self, $column, $info, @rest) = @_;
    $self->next::method($column, $info, @rest);

    return unless defined $info->{'is_yaml'};

    my $freezer;
    if (defined $info->{'size'}){
       $freezer = get_bounded_column_freezer($info->{'size'});
    } else {
       $freezer = \&unbounded_freezer;
    }


    $self->inflate_column(
        $column => {
            inflate => sub {
                return YAML::Load(shift);
            },
            deflate => $freezer,
        }
    );
};

sub get_bounded_column_freezer {
   my ($size) = @_;
   return sub {
     my $s = YAML::Dump(shift);
     croak "serialization too big" if (length($s) > $size);
     return $s;
   };
}

sub unbounded_freezer {
   return YAML::Dump(shift);
}

1;
