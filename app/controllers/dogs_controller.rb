class DogsController < ApplicationController

  def index
  end

  def submit
    response = HTTParty.get('https://dog.ceo/api/breeds/image/random')
    @message = JSON.parse(response.body)['message']

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update("image", partial: "image") }
    end
  end
end
