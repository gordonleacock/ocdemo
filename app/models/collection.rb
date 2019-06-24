class Collection < Valkyrie::Resource
  attribute :title, Valkyrie::Types::Strict::String
  attribute :coll_id, Valkyrie::Types::Strict::String.optional
  attribute :subcoll_id, Valkyrie::Types::Strict::String.optional
  # attribute :hdr_create_date, Valkyrie::Types::Datetime.optional
  # attribute :hdr_last_modified_date, Valkyrie::Types::Datetime.optional
  attribute :hdr_record_status, Valkyrie::Types::Strict::String.optional
  attribute :hdr_agent_role, Valkyrie::Types::Strict::String.optional
  attribute :hdr_agent_type, Valkyrie::Types::Strict::String.optional
  attribute :hdr_agent_name, Valkyrie::Types::Strict::String.optional
  # ====================
  attribute :common_mdtype, Valkyrie::Types::Strict::String.optional
  attribute :common_mime_type, Valkyrie::Types::Strict::String.optional
  attribute :common_label, Valkyrie::Types::String.optional
  attribute :common_dcterms_type, Valkyrie::Types::String.optional
  attribute :common_dcterms_conformsTo, Valkyrie::Types::String.optional
  attribute :common_dcterms_identifier, Valkyrie::Types::String.optional
  attribute :common_dcterms_title, Valkyrie::Types::String.optional
  attribute :common_dcterms_subject, Valkyrie::Types::String.optional
  # ====================
  attribute :collections_mdtype, Valkyrie::Types::Strict::String.optional
  attribute :collections_mime_type, Valkyrie::Types::Strict::String.optional
  attribute :collections_label, Valkyrie::Types::String.optional
  attribute :collections_memberOf, Valkyrie::Types::String.optional
  # ====================
  attribute :member_ids, Valkyrie::Types::Array.optional
  attribute :file_identifiers, Valkyrie::Types::Array.meta(ordered: true).optional
end