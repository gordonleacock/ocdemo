class ItemChangeSet < Valkyrie::ChangeSet
  property :id
  property :title
  property :creator
  property :file_identifiers
  property :coll_id
  property :subcoll_id
  property :filegroup_id
  property :filegroup_use
  property :sequence
  property :file, virtual: true, multiple: false
  property :checksum
  property :checksum_type
  property :size
  property :created
  property :mime_type
  property :loc_type
  property :xlink_href


  validates :title, presence: true
  validates :creator, presence: true
  validates :file, presence: true
  validates :checksum, presence: true
  validates :checksum_type, presence: true
  validates :size, presence: true
  validates :created, presence: true
end
