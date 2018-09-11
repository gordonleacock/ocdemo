# Generated with `rails generate valkyrie:model Armor`
class Armor < Valkyrie::Resource
  attribute :title, Valkyrie::Types::Set
  attribute :member_ids, Valkyrie::Types::Array
end
