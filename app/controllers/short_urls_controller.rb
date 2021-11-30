class ShortUrlsController < ApplicationController
  skip_before_action :authenticate_user!

  def redirect
    @short_url = ShortUrl.find_by_identifier(params[:identifier])
    if @short_url
      redirect_to @short_url.long_url
    else
      flash[:error] = "The link you specified is invalid: #{request.original_url}"
      redirect_to root_url
    end
  end
end
