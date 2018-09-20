class ArmorChangeSet < Valkyrie::ChangeSet
  property :title
  property :member_ids

  validates :title, presence: true
end
