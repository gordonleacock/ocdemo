class HelmetChangeSet < Valkyrie::ChangeSet
  property :title
  property :creator

  validates :title, presence: true
end
