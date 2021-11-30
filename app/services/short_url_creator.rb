class ShortUrlCreator
  def initialize(long_url)
    @long_url = long_url
  end

  def create!
    find_or_create
    "#{APP_URL}/short/#{@short_url.identifier}"
  end

  protected

  def find_or_create
    @short_url = ShortUrl.where(long_url: @long_url).first_or_initialize(long_url: @long_url)
    @short_url.save
  end
end
