require "rails_helper"

RSpec.describe ArmorController do
  let(:metadata_adapter) { Valkyrie.config.metadata_adapter }
  let(:persister) { metadata_adapter.persister }
  let(:query_service) { metadata_adapter.query_service }
  let(:saved_armor) { persister.save(resource: Armor.new(title: 'Tarnhelm')) }

  describe "new" do
    it "renders the new record form" do
      get :new
      expect(response).to render_template("armor/new")
    end
  end

  describe "edit" do
    before do
      saved_armor
    end
    it "renders the edit record form" do
      get :edit, params: { id: saved_armor.id }
      expect(response).to render_template("armor/edit")
    end
  end

  describe "index" do
    before do
      saved_armor
    end
    render_views
    it "displays the record" do
      get :index
      expect(response.body).to include("Tarnhelm")
      expect(assigns(:armor)).to include(saved_armor)
    end
  end

  describe "show" do
    before do
      saved_armor
    end
    render_views
    it "displays the record" do
      get :show, params: { id: saved_armor.id }
      expect(response.body).to include("Tarnhelm")
      expect(assigns(:armor)).to eq(saved_armor)
    end
  end

  describe "create" do
    context "with valid input" do
      it "creates a record" do
        post :create, params: { armor: { title: 'Helm of Awe' } }
        expect(assigns(:armor).title).to eq('Helm of Awe')
      end
    end
    context "with invalid input" do
      it "renders the new form" do
        post :create, params: { armor: { title: '' } }
        expect(response).to render_template("armor/new")
        expect(assigns(:armor)).to be false
      end
    end
  end

  describe "update" do
    before do
      saved_armor
    end

    context "with valid input" do
      it "updates the record" do
        patch :update, params: { id: saved_armor.id, armor: { title: 'Helm of Awe' } }
        reloaded = query_service.find_by(id: saved_armor.id)
        expect(reloaded.title).to eq('Helm of Awe')
      end
    end
    context "with invalid input" do
      it "renders the edit form" do
        patch :update, params: { id: saved_armor.id, armor: { title: '' } }
        expect(response).to render_template("armor/edit")

        reloaded = query_service.find_by(id: saved_armor.id)
        expect(reloaded.title).to eq('Tarnhelm')
      end
    end
  end

  describe "delete" do
    before do
      saved_armor
    end

    it "deletes the record" do
      delete :destroy, params: { id: saved_armor.id }
      expect { query_service.find_by(id: saved_armor.id) }.to raise_error ::Valkyrie::Persistence::ObjectNotFoundError
    end
  end
end
