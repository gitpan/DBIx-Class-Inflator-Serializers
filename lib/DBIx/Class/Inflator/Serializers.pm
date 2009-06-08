package DBIx::Class::Inflator::Serializers;

use strict;
use warnings;

=head1 NAME

DBIx::Class::Inflator::Serializers - Inflators to serialize data structures for DBIx::Class

=head1 SYNOPSIS

  package MySchema::Table;
  use base 'DBIx::Class';

  __PACKAGE__->load_components('InflateColumn::JSON', 'Core');
  __PACKAGE__->add_columns(
    'serialized' => {
      'data_type' => 'VARCHAR',
      'size'      => 255,
      'is_json'   => 1
    }
  );

Then in your code...

  my $struct = { 'I' => { 'am' => 'a struct' };
  $obj->serialized($struct);
  $obj->update;

And you can recover your data structure with:

  my $obj = ...->find(...);
  my $struct = $obj->serialized;

The data structures you assign to "serialized" will be saved in the database in JSON format.

=head1 DESCRIPTION

These modules help you store and access serialized data structures in the columns of your DB from your DBIx::Classes. They are inspired from the DBIx::Class::Manual::FAQ and the DBIC test suite, and provide a bit more protection than the inflators proposed in the FAQ. The intention is to provide a suite of well proven and reusable inflators and deflators to complement DBIx::Class.

Added features for these inflators are:
 - throw an exception if the serialization doesn't fit in the field
 - throw an exception if the deserialization results in an error

Right now there are three serializers:
 - Storable
 - JSON
 - YAML

=head1 USAGE

1. Choose your serializer: JSON, YAML or Storable (substitute SERIALIZER below with one of these)

2. Add 'Inflator::SERIALIZER' into the load_components of your table class

3. add 'is_SERIALIZER' => 1 to the properties of the column that you want to (de/i)nflate
   with the SERIALIZER.

=head1 NOTES

As stated in the DBIC FAQ: "Be careful not to overuse this capability, however. If you find yourself depending more and more on some data within the inflated column, then it may be time to factor that data out."

=head1 AUTHOR

    Jose Luis Martinez
    CPAN ID: JLMARTIN
    CAPSiDE
    jlmartinez@capside.com
    http://www.pplusdomain.net

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.


=head1 SEE ALSO

DBIx::Class, DBIx::Class::Manual::FAQ

=cut

#################### main pod documentation end ###################


1;
