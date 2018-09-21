class HelmetChangeSet < Valkyrie::ChangeSet
  property :title
  property :creator
  property :file, virtual: true, multiple: false

  validates :title, presence: true
end
