class HelmetsController < ApplicationController
  before_action :set_helmet, only: [:show, :edit, :update, :destroy]
  before_action :set_parent, only: [:create]

  def index
    @helmets = metadata_adapter.query_service.find_all_of_model(model: Helmet)
  end

  def show
  end

  def new
    @helmet = Helmet.new

    # set the parent_id if we are creating a Helmet as a child of an Armor instance
    @parent_id = params[:parent_id] if params[:parent_id]
  end

  def edit
  end

  def create
    respond_to do |format|
      @change_set = ::HelmetChangeSet.new(Helmet.new).prepopulate!

      @helmet = save(@change_set)
      if @helmet
        attach_file(@change_set.file, @helmet) if @change_set.file
        destination = @parent.nil? ? @helmet : add_to_parent(@helmet)

        format.html { redirect_to destination, notice: 'Helmet was successfully created.' }
        format.json { render :show, status: :created, location: @helmet }
      else
        format.html { flash[:alert] = @change_set.errors.to_h; render :new }
        format.json { render json: @helmet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @change_set = ::HelmetChangeSet.new(@helmet).prepopulate!

      if save(@change_set)
        attach_file(@change_set.file, @helmet) if @change_set.file

        format.html { redirect_to @helmet, notice: 'Helmet was successfully updated.' }
        format.json { render :show, status: :ok, location: @helmet }
      else
        format.html { render :edit, alert: @change_set.errors }
        format.json { render json: @change_set.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    metadata_adapter.persister.delete(resource: @helmet)
    respond_to do |format|
      format.html { redirect_to helmets_url, notice: 'Helmet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # validate and save changes using a change set
    def save(change_set)
      return false unless change_set.validate(helmet_params.to_h)
      change_set.sync && metadata_adapter.persister.save(resource: change_set.resource)
    end

    # upload file to the storage adpater, and attach id to the resource
    def attach_file(file, resource)
      # delete any existing file
      storage_adapter.delete(id: resource.file_identifiers.first) if resource.file_identifiers.first

      uploaded_file = storage_adapter.upload(file: file, resource: resource,
                                             original_filename: file.original_filename)
      resource.file_identifiers = [{file_id: uploaded_file.id, original_filename: file.original_filename, updated_at: DateTime.now.utc}]
      metadata_adapter.persister.save(resource: resource)
    end

    # if we are being created as a child of an Armor instance, make this Helmet a member of it
    def add_to_parent(helmet)
      @parent.member_ids ||= []
      @parent.member_ids << helmet.id
      metadata_adapter.persister.save(resource: @parent)
      armor_path(@parent.id)
    end

    # load the parent resource, if specified
    def set_parent
      @parent ||= metadata_adapter.query_service.find_by(id: parent_id) if parent_id
    end

    def parent_id
      return unless params[:helmet]
      params[:helmet][:parent_id]
    end

    def set_helmet
      @helmet = metadata_adapter.query_service.find_by(id: params[:id])
    end

    def helmet_params
      params.require(:helmet).permit(:id, :title, :creator, :file)
    end

    def metadata_adapter
      Valkyrie.config.metadata_adapter
    end

    def storage_adapter
      Valkyrie.config.storage_adapter
    end
end
