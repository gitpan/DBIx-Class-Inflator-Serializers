# -*- perl -*-

use Test::More;
eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD coverage" if $@;

plan tests => 3;

pod_coverage_ok(
     'DBIx::Class::Inflator::Storable',
     {
     also_private => [
       'register_column',
       'get_bounded_column_freezer',
       'unbounded_freezer'
     ]
     });

pod_coverage_ok(
     'DBIx::Class::Inflator::JSON',
     {
     also_private => [
       'register_column',
       'get_bounded_column_freezer',
       'unbounded_freezer'
     ]
     });

pod_coverage_ok(
     'DBIx::Class::Inflator::YAML',
     {
     also_private => [
       'register_column',
       'get_bounded_column_freezer',
       'unbounded_freezer'
     ]
     });


