package DBIx::Class::Inflator::JSON;

=head1 NAME

DBIx::Class::Inflator::JSON - Inflate and deflate columns in JSON format

=cut

use JSON::Any;

use strict;
use warnings;
use Carp;

our $VERSION = '0.01';


sub register_column {
    my ($self, $column, $info, @rest) = @_;
    $self->next::method($column, $info, @rest);

    return unless defined $info->{'is_json'};

    my $freezer;
    if (defined $info->{'size'}){
       $freezer = get_bounded_column_freezer($info->{'size'});
    } else {
       $freezer = \&unbounded_freezer;
    }


    $self->inflate_column(
        $column => {
            inflate => sub {
                return JSON::Any->from_json(shift);
            },
            deflate => $freezer,
        }
    );
};

sub get_bounded_column_freezer {
   my ($size) = @_;
   return sub {
     my $s = JSON::Any->to_json(shift);
     croak "serialization too big" if (length($s) > $size);
     return $s;
   };
}

sub unbounded_freezer {
   return JSON::Any->to_json(shift);
}

1;
