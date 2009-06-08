package # hide from PAUSE
    DBICTest::Schema::SerializeJSON;

use base qw/DBIx::Class/;

__PACKAGE__->load_components (qw/Inflator::JSON Core/);

__PACKAGE__->table('testtable');
__PACKAGE__->add_columns(
  'testtable_id' => {
    data_type => 'integer',
  },
  'serial1' => {
    data_type => 'varchar',
    size => 100,
    is_json => 1
  },
  'serial2' => {
    data_type => 'varchar',
    is_json => 1
  }
);

__PACKAGE__->set_primary_key('testtable_id');

1;

