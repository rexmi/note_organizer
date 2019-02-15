module PagesHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new()
    markdown = Redcarpet::Markdown.new(renderer, {:fenced_code_blocks=>true})
    return markdown.render(text).html_safe
  end
end
