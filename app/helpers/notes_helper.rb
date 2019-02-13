module NotesHelper
  def tags_format(array)
    return if array.empty?
    result = ""
    array.each do |i|
      result << (i + ",")
    end
    return "{" + remove_trailing_comma(result) + "}"
  end

  def remove_trailing_comma(string)
    if string[-1] == ","
      string = string[0...-1]
    end
    return string
  end
end
