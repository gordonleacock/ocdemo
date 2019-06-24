class CollectionChangeSet < Valkyrie::ChangeSet
  property :title, default: 'xyz'
  property :coll_id, default: 'abc'
  property :subcoll_id
  # property :hdr_create_date, default: 2018-08-30T20:18:47
  # property :hdr_last_modified_date, default: 2018-08-30T20:18:47
  property :hdr_record_status, default: 'BAGGED'
  property :hdr_agent_role, default: 'CUSTODIAN'
  property :hdr_agent_type, default: 'ORGANIZATION'
  property :hdr_agent_name, default: 'DLPS'
  # ====================
  property :common_mdtype, default: 'DC'
  property :common_mime_type, default: 'text/xml'
  property :common_label, default: 'Common Metadata'
  property :common_dcterms_type, default: 'serialissue'
  property :common_dcterms_conformsTo, default: 'http://www.tei-c.org/SIG/Libraries/teiinlibraries/'
  property :common_dcterms_identifier, default: 'taj1895.0001.001'
  property :common_dcterms_title, default: 'The American Jewess: Vol. 1, No. 1'
  property :common_dcterms_subject, default: 'Jewish women -- Periodicals. -- United States'
  # ====================
  property :collections_mdtype, default: 'DC'
  property :collections_mime_type, default: 'text/xml'
  property :collections_label, default: 'In Collections'
  property :collections_memberOf, default: 'urn:x-umich:collection:amjewess'
  # ====================
  property :file_identifiers
  property :member_ids, default: []

  validates :title, presence: true
  # validates :coll_id, presence: true
  # validates :common_label, presence: true
  # validates :collections_label, presence: true
  # validates :common_dcterms_title, presence: true
end
