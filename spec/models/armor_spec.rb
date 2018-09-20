require "rails_helper"
require "valkyrie/specs/shared_specs"

describe Armor do
  let(:metadata_adapter) { Valkyrie.config.metadata_adapter }
  let(:persister) { metadata_adapter.persister }
  let(:query_service) { metadata_adapter.query_service }
  let(:resource_klass) { described_class }
  let(:helmet1) { Helmet.new(title: 'Tarnhelm') }
  let(:helmet2) { Helmet.new(title: 'Helm of Awe') }

  it_behaves_like 'a Valkyrie::Resource'

  it "has a title" do
    r = described_class.new(title: 'My Armor')
    saved = persister.save(resource: r)
    reloaded = query_service.find_by(id: saved.id)
    expect(reloaded.title).to eq('My Armor')
  end

  it "has an ordered list of members" do
    helmets = persister.save_all(resources: [helmet1, helmet2])
    helmet_ids = helmets.map(&:id)
    r = described_class.new(member_ids: helmet_ids)
    saved = persister.save(resource: r)
    reloaded = query_service.find_by(id: saved.id)
    expect(reloaded.member_ids).to eq(helmet_ids)
  end
end
