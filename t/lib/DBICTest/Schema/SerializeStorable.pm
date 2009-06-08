package # hide from PAUSE
    DBICTest::Schema::SerializeStorable;

use base qw/DBIx::Class/;

__PACKAGE__->load_components (qw/Inflator::Storable Core/);

__PACKAGE__->table('testtable');
__PACKAGE__->add_columns(
  'testtable_id' => {
    data_type => 'integer',
  },
  'serial1' => {
    data_type => 'varchar',
    size => 100,
    is_storable => 1
  },
  'serial2' => {
    data_type => 'varchar',
    is_storable => 1
  }
);

__PACKAGE__->set_primary_key('testtable_id');

1;

