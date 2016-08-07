class MaterializedSearchSuggestion

  def self.seed
    [Activity].each do |cl|
      cl.find_each do |item|
        self.index_term(item.title)
        item.title.split.each { |t| self.index_term(t.gsub(".",""))}
      end
    end
  end

  def self.index_term(term)
    1.upto(term.length-1) do |n|
      prefix = term[0, n]
      $redis.zincrby "search-suggestions:#{prefix.downcase}", 1, term.downcase
    end
  end

  def self.terms_for(prefix)
    $redis.zrevrange "search-suggestions:#{prefix.downcase}", 0, 9
  end

  def self.clear
    keys = $redis.keys "search-suggestions:*"
    $redis.del(*keys) unless keys.empty?
  end
end
