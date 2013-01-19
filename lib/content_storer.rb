require 'digest'

class ContentStorer
  def initialize
    @storage = Hash.new
    @salt = SecureRandom.base64
  end

  def store content
    return '' if content.nil? || content.empty?
    key = Digest::SHA1.hexdigest(@salt + content)
    @storage[key] = content
    key
  end

  def retreive key
    @storage[key]
  end
end
