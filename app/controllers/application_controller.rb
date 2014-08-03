class ApplicationController < ActionController::API
  protected

  def serialization_options
    { base_url: request.base_url }
  end
end
