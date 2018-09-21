require "rails_helper"

RSpec.describe FilesController do
  let(:metadata_adapter) { Valkyrie.config.metadata_adapter }
  let(:storage_adapter) { Valkyrie.config.storage_adapter }
  let(:persister) { metadata_adapter.persister }
  let(:file_attachment) { fixture_file_upload("spec/fixtures/valkyrie.png") }
  let(:saved_helmet) { persister.save(resource: Helmet.new(title: 'Tarnhelm')) }

  before do
    uploaded_file = storage_adapter.upload(file: file_attachment, resource: saved_helmet,
                                           original_filename: file_attachment.original_filename)
    saved_helmet.file_identifiers = [{file_id: uploaded_file.id, original_filename: file_attachment.original_filename, updated_at: DateTime.now.utc}]
    metadata_adapter.persister.save(resource: saved_helmet)
  end

  describe "show" do
    context "with a valid file" do
      it "serves the file" do
        get :show, params: { resource_id: saved_helmet.id }
        expect(response.content_length).to eq(20450)
        expect(response.content_type).to eq("image/png")
        expect(response.headers["Content-Disposition"]).to eq('inline; filename="valkyrie.png"')
      end
    end
    context "with an invalid file" do
      it "returns a 404 error" do
        get :show, params: { resource_id: 'asdf' }
        expect(response.status).to eq(404)
      end
    end
  end
end
