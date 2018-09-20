require "rails_helper"
require "valkyrie/specs/shared_specs"

describe ArmorChangeSet do
  let(:resource_klass) { described_class }
  let(:change_set) { described_class.new(Armor.new) }

  it_behaves_like 'a Valkyrie::ChangeSet'

  it "allows setting title and member_ids" do
    expect(change_set.validate(title: 'Abc', member_ids: ['123', '345'])).to be true
  end
end
