require 'json'
require 'uri/http'
require 'public_suffix'
require 'securerandom'

# Accessor to Redis to save/retrieve info
class Shortly
  HASH_LENGTH = 8

  def self.get(hash_key)
    url, _ = $redis.multi do
      $redis.get hash_key
      $redis.incr "GET"
    end
    puts "FOUND #{hash_key}: #{url}"
    URI.parse(url).scheme.nil? ? "http://#{url}" : url
  end

  def self.save(url)
    hash_key = SecureRandom.urlsafe_base64(HASH_LENGTH)
    domain = self.get_domain(url)

    # Set URL into the store and increment the counters on the domain
    $redis.multi do
      $redis.set hash_key, url
      $redis.incr domain
      $redis.incr "PUT"
    end
    puts "SAVED: #{url} ON KEY #{hash_key}; DOMAIN: #{domain}"
    hash_key
  end

  def self.stats(domain=nil)
    if domain.nil? 
      get_stat, put_stat = $redis.multi do
        $redis.get "GET"
        $redis.get "PUT"
      end
      {get: get_stat, put: put_stat}.to_json
    else
      clean_domain = get_domain(domain)
      domain_stat = $redis.get clean_domain
    end
  end

  def self.get_domain(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host
    PublicSuffix.parse(host).domain
  end
end
