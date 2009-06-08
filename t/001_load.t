# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 3;

BEGIN { 
    use_ok( 'DBIx::Class::Inflator::Storable' ); 
    use_ok( 'DBIx::Class::Inflator::YAML' ); 
    use_ok( 'DBIx::Class::Inflator::JSON' ); 
}

#my $object = DBIx::Class::Inflator::Serializers->new ();
#isa_ok ($object, 'DBIx::Class::Inflator::Serializers');


