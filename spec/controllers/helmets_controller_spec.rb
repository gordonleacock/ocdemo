require "rails_helper"

RSpec.describe HelmetsController do
  let(:metadata_adapter) { Valkyrie.config.metadata_adapter }
  let(:persister) { metadata_adapter.persister }
  let(:query_service) { metadata_adapter.query_service }
  let(:saved_helmet) { persister.save(resource: Helmet.new(title: 'Tarnhelm')) }
  let(:saved_armor) { persister.save(resource: Armor.new(title: "Siegfried's Armor")) }

  describe "new" do
    it "renders the new record form" do
      get :new
      expect(response).to render_template("helmets/new")
    end
  end

  describe "edit" do
    before do
      saved_helmet
    end
    it "renders the edit record form" do
      get :edit, params: { id: saved_helmet.id }
      expect(response).to render_template("helmets/edit")
    end
  end

  describe "index" do
    before do
      saved_helmet
    end
    render_views
    it "displays the record" do
      get :index
      expect(response.body).to include("Tarnhelm")
      expect(assigns(:helmets)).to include(saved_helmet)
    end
  end

  describe "show" do
    before do
      saved_helmet
    end
    render_views
    it "displays the record" do
      get :show, params: { id: saved_helmet.id }
      expect(response.body).to include("Tarnhelm")
      expect(assigns(:helmet)).to eq(saved_helmet)
    end
  end

  describe "create" do
    context "with valid input" do
      it "creates a record" do
        post :create, params: { helmet: { title: 'Helm of Awe' } }
        expect(assigns(:helmet).title).to eq('Helm of Awe')
      end
    end
    context "with invalid input" do
      render_views
      it "renders the new form" do
        post :create, params: { helmet: { title: '' } }
        expect(response).to render_template("helmets/new")
        expect(response.body).to include("title: can't be blank")
        expect(assigns(:helmet)).to be false
      end
    end
    context "with a parent" do
      it "creates a record and makes it a member of the parent" do
        post :create, params: { helmet: { title: 'Helm of Awe', parent_id: saved_armor.id } }
        created = assigns(:helmet)
        expect(created.title).to eq('Helm of Awe')
        reloaded_parent = query_service.find_by(id: saved_armor.id)
        expect(reloaded_parent.member_ids).to include(created.id)
      end
    end
  end

  describe "update" do
    before do
      saved_helmet
    end

    context "with valid input" do
      it "updates the record" do
        patch :update, params: { id: saved_helmet.id, helmet: { title: 'Helm of Awe' } }
        reloaded = query_service.find_by(id: saved_helmet.id)
        expect(reloaded.title).to eq('Helm of Awe')
      end
    end
    context "with invalid input" do
      it "renders the edit form" do
        patch :update, params: { id: saved_helmet.id, helmet: { title: '' } }
        expect(response).to render_template("helmets/edit")

        reloaded = query_service.find_by(id: saved_helmet.id)
        expect(reloaded.title).to eq('Tarnhelm')
      end
    end
  end

  describe "delete" do
    before do
      saved_helmet
    end

    it "deletes the record" do
      delete :destroy, params: { id: saved_helmet.id }
      expect { query_service.find_by(id: saved_helmet.id) }.to raise_error ::Valkyrie::Persistence::ObjectNotFoundError
    end
  end
end
