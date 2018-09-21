require "rails_helper"
require "valkyrie/specs/shared_specs"

describe Helmet do
  let(:metadata_adapter) { Valkyrie.config.metadata_adapter }
  let(:persister) { metadata_adapter.persister }
  let(:query_service) { metadata_adapter.query_service }
  let(:resource_klass) { described_class }

  it_behaves_like 'a Valkyrie::Resource'

  it "has a title" do
    r = described_class.new(title: 'Tarnhelm')
    saved = persister.save(resource: r)
    reloaded = query_service.find_by(id: saved.id)
    expect(reloaded.title).to eq('Tarnhelm')
  end

  it "has an ordered list of creators" do
    r = described_class.new(creator: ['Mime', 'Alberich'])
    saved = persister.save(resource: r)
    reloaded = query_service.find_by(id: saved.id)
    expect(reloaded.creator).to eq(['Mime', 'Alberich'])
  end
end
