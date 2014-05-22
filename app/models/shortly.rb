# Accessor to Redis to save/retrieve info
class Shortly
  def self.get(hash)
    "HASH"
  end

  def self.save(url)
    "SAVED: #{url}"
  end

  def self.stats(domain=nil)
    domain.nil? ? "ALL STATS" : "DOMAIN STATS"
  end
end
