class Api::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.json {render json: {data: {}}.to_json, status: :not_found}
    end
  end
end