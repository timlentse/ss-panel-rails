module Devise
  module Encryptable
    module Encryptors
      class Sha256 < Base
        def self.digest(password, stretches, salt, pepper)
          Digest::SHA256.hexdigest(password)
        end
      end
    end
  end
end
