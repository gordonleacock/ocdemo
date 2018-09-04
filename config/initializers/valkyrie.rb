require 'valkyrie'
Rails.application.config.to_prepare do
  Valkyrie::MetadataAdapter.register( Valkyrie::Persistence::Memory::MetadataAdapter.new, :memory)
  Valkyrie::StorageAdapter.register( Valkyrie::Storage::Memory.new, :memory)
end
