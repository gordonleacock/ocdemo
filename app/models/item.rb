class Item < Valkyrie::Resource
  attribute :title, Valkyrie::Types::String
  attribute :creator, Valkyrie::Types::Array.meta(ordered: true)
  attribute :file_identifiers, Valkyrie::Types::Set.optional
  attribute :coll_id, Valkyrie::Types::Set.optional
  attribute :subcoll_id, Valkyrie::Types::Set.optional
  attribute :filegroup_id, Valkyrie::Types::Strict::String.optional
  attribute :filegroup_use, Valkyrie::Types::Strict::String.optional
  attribute :sequence, Valkyrie::Types::Strict::Integer.optional
  attribute :file, Valkyrie::Types::Strict::String
  attribute :checksum, Valkyrie::Types::Strict::String
  attribute :checksum_type, Valkyrie::Types::Strict::String
  attribute :size, Valkyrie::Types::Strict::Integer
  attribute :created, Valkyrie::Types::Strict::Datetime
  attribute :mime_type, Valkyrie::Types::Strict::String.optional
  attribute :loc_type, Valkyrie::Types::String.optional
  attribute :xlink_href, Valkyrie::Types::String.optional
end