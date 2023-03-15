class Url < ApplicationRecord
    def generate_short_url
        hashed_id = Digest::MD5.hexdigest(id.to_s)[0..6]

        while Url.where(short_url: hashed_id).exists?
          salt = SecureRandom.alphanumeric(4) 
          hashed_id = Digest::MD5.hexdigest(id.to_s + salt)[0..6]
        end

        update(short_url: hashed_id)
        short_url
    end
end