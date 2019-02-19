module Notes_Mod
  class << self
    def sanitize(input)
      input.gsub!(/\W+/, ' ')
      return input.split(" ") if input.length > 1
      return input
    end

    def rank_title(title, keys)
      if title.any? {|i| keys.include? i}
        result = title - (title - keys)
        return result.length
      else
        return 0
      end
    end

    def create_key_tag(input)
      keywords = input.split(",")
      keys, tags = keywords.shift, keywords
      return keys, tags
    end

    def ranking(title, key_title)
      score = 0
      title = sanitize(title)
      key_title = sanitize(key_title)
      score += rank_title(title, key_title)
      score
    end

    def give_score(input, keys)
      result = {}
      input.each do |d|
        score = ranking(d.title, keys)
        if score > 0
          result[d.id.to_s] = score
        end
      end
      return result
    end
  end
end