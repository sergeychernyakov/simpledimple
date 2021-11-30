class ShortUrl < ApplicationRecord
  before_validation :generate_identifier

  def generate_identifier
    return unless identifier.nil?

    new_identifier = ShortUrl.random_identifier

    self.identifier = if ShortUrl.find_by_identifier(new_identifier)
                        generate_identifier
                      else
                        new_identifier
                      end
  end

  class << self
    def random_identifier
      o = [('a'..'z'), ('0'..'9')].map { |i| i.to_a }.flatten.delete_if { |c| %w[o l 0 1].include?(c) }
      string = (0..4).map { o[rand(o.length)] }.join
    end
  end
end
