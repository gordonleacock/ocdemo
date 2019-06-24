class CollectionController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  before_action :set_members, only: [:show]

  def index
    @collection = metadata_adapter.query_service.find_all_of_model(model: Collection)
  end

  def show
  end

  def new
    @collection = Collection.new
  end

  def edit
  end

  def create
    respond_to do |format|
      @change_set = ::CollectionChangeSet.new(Collection.new).prepopulate!

      @collection = save(@change_set)

      if @collection
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new, alert: @change_set.errors }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @change_set = ::CollectionChangeSet.new(@collection).prepopulate!

      if save(@change_set)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit, alert: @change_set.errors }
        format.json { render json: @change_set.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    metadata_adapter.persister.delete(resource: @collection)
    respond_to do |format|
      format.html { redirect_to collection_index_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def metadata_adapter
      Valkyrie.config.metadata_adapter
    end

    def collection_params
      params.require(:collection).permit(:id, :title, :coll_id)
    end

    def set_collection
      @collection = metadata_adapter.query_service.find_by(id: params[:id])
    end

    # load the member objects, if any
    def set_members
      @members = metadata_adapter.query_service.find_many_by_ids(ids: @collection.member_ids) unless @collection.member_ids.empty?
    end

    # validate and save changes using a change set
    def save(change_set)
      return false unless change_set.validate(collection_params.to_h)
      change_set.sync && metadata_adapter.persister.save(resource: change_set.resource)
    end
end
