package ParentSchema::Result;

use parent 'DBIx::Class::Core';

__PACKAGE__->load_components('Helper::Row::RelationshipDWIM');

sub default_result_namespace { 'ParentSchema::Result' }

1;
