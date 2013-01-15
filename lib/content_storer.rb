require 'digest'

class ContentStorer
  def initialize
    @storage = Hash.new
    @salt = SecureRandom.base64
  end

  def store content
    return '' if content.nil? || content.size == 0
    key = Digest::SHA1.hexdigest(@salt + content)
    @storage[key] = content
    key
  end

  def retreive key
    @storage.fetch key
  end
end
