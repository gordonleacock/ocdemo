class Helmet < Valkyrie::Resource
  attribute :title, Valkyrie::Types::Set
  attribute :creator, Valkyrie::Types::Array.meta(ordered: true)
end
