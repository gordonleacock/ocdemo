class ArmorController < ApplicationController
  before_action :set_armor, only: [:show, :edit, :update, :destroy]
  before_action :set_members, only: [:show]

  def index
    @armor = metadata_adapter.query_service.find_all_of_model(model: Armor)
  end

  def show
  end

  def new
    @armor = Armor.new
  end

  def edit
  end

  def create
    @armor = metadata_adapter.persister.save(resource: Armor.new(armor_params.to_h))

    respond_to do |format|
      if @armor
        format.html { redirect_to @armor, notice: 'Armor was successfully created.' }
        format.json { render :show, status: :created, location: @armor }
      else
        format.html { render :new }
        format.json { render json: @armor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @change_set = ::ArmorChangeSet.new(@armor).prepopulate!

      if save(@change_set)
        format.html { redirect_to @armor, notice: 'Armor was successfully updated.' }
        format.json { render :show, status: :ok, location: @armor }
      else
        format.html { render :edit }
        format.json { render json: @change_set.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    metadata_adapter.persister.delete(resource: @armor)
    respond_to do |format|
      format.html { redirect_to armor_index_url, notice: 'Armor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # validate and save changes using a change set
    def save(change_set)
      return false unless change_set.validate(armor_params.to_h)
      change_set.sync && metadata_adapter.persister.save(resource: change_set.resource)
    end

    # load the member objects, if any
    def set_members
      @members = metadata_adapter.query_service.find_many_by_ids(ids: @armor.member_ids) unless @armor.member_ids.empty?
    end

    def set_armor
      @armor = metadata_adapter.query_service.find_by(id: params[:id])
    end

    def armor_params
      params.require(:armor).permit(:id, :title, :member_ids)
    end

    def metadata_adapter
      Valkyrie.config.metadata_adapter
    end
end
