module Jwt::Keys
  module_function

  def private_key
    OpenSSL::PKey::RSA.new Rails.root.join('keys/jwtRS256.key').read
  end

  def public_key
    OpenSSL::PKey::RSA.new Rails.root.join('keys/jwtRS256.key.pub').read
  end
end