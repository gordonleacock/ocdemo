class Helmet < Valkyrie::Resource
  attribute :title, Valkyrie::Types::String
  attribute :creator, Valkyrie::Types::Array.meta(ordered: true)
end
