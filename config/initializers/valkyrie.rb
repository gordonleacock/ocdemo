require 'valkyrie'
Rails.application.config.to_prepare do
  Valkyrie::MetadataAdapter.register( Valkyrie::Persistence::Memory::MetadataAdapter.new, :memory)
  Valkyrie::MetadataAdapter.register( Valkyrie::Persistence::Postgres::MetadataAdapter.new, :postgres)
  Valkyrie::StorageAdapter.register( Valkyrie::Storage::Memory.new, :memory)
  Valkyrie::StorageAdapter.register( Valkyrie::Storage::Disk.new(base_path: 'tmp/files'), :disk)
end
