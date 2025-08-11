class StaticPagesController < ApplicationController
  include HTTParty
  base_uri 'https://api.pexels.com/v1'

  def home
    if params[:collection_id].present?
      api_key = Rails.application.credentials.pexels[:api_key]
      response = HTTParty.get(
        "https://api.pexels.com/v1/collections/#{params[:collection_id]}?per_page=10",
        headers: { "Authorization" => api_key }
      )
      if response.code == 200
        @photos = response.parsed_response["media"]
      else
        flash.now[:alert] = "Error fetching photos. Please check collection ID."
      end
    end
  end
end
