module Notes_Mod
  class << self
    def sanitize(input)
      input.gsub!(/\W+/, ' ')
      return input.split(" ") if input.length > 1
      return input
    end

    def give_relative_score(title, keys)
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
      score += give_relative_score(title, key_title)
      score
    end

    def tag_ranking(tags, key_tags)
      return 0 if tags.empty?
      score = 0
      remove_spaces key_tags
      score += give_relative_score(tags, key_tags)
      score
    end

    def remove_spaces(arr_str)
      arr_str.each do |d|
        d.lstrip!
        d.rstrip!
      end
    end

    def give_score(input, keys, tags)
      result = {}
      input.each do |d|
        title_score = ranking(d.title, keys)
        tag_score = tag_ranking(d.tags, tags)
        if title_score > 0
          result[d.id.to_s] = [title_score, tag_score]
        end
      end
      return result
    end
  end
end