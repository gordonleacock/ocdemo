# frozen_string_literal: true
class FilesController < ApplicationController

  def show
    if resource && binary_file
      send_content
    else
      render_404
    end
  end

  private

    def storage_adapter
      Valkyrie.config.storage_adapter
    end

    def query_service
      Valkyrie.config.metadata_adapter.query_service
    end

    def render_404
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
        format.any  { head :not_found }
      end
    end

    def send_content
      prepare_file_headers
      send_file(binary_file.disk_path, filename: original_filename, disposition: :inline)
    end

    # Copied from hydra-head and adjusted to handle the fact that we don't have a
    # modified_date in Valkyrie yet.
    def prepare_file_headers
      response.headers["Content-Length"] ||= binary_file.size.to_s
      # Prevent Rack::ETag from calculating a digest over body
      response.headers["Last-Modified"] = updated_at
    end

    def binary_file
      @binary_file ||= storage_adapter.find_by(id: file_desc[:file_id])
    end

    def resource
      @resource ||= query_service.find_by(id: Valkyrie::ID.new(params[:resource_id]))
    rescue Valkyrie::Persistence::ObjectNotFoundError
      nil
    end

    def file_desc
      resource.file_identifiers.first
    end

    def original_filename
      @original_filename ||= file_desc[:original_filename]
    end

    def updated_at
      file_desc[:updated_at].strftime("%a, %d %b %Y %T GMT") if file_desc[:updated_at]
    end
end
