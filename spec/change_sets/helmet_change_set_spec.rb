require "rails_helper"
require "valkyrie/specs/shared_specs"

describe HelmetChangeSet do
  let(:resource_klass) { described_class }
  let(:change_set) { described_class.new(Helmet.new) }

  it_behaves_like 'a Valkyrie::ChangeSet'

  it "allows setting title and creator" do
    expect(change_set.validate(title: 'Abc', creator: ['Def', 'Ghi'])).to be true
  end
end
