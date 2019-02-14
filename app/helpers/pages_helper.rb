module PagesHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new()
    markdown = Redcarpet::Markdown.new(renderer, {})
    @s = markdown.render(text).html_safe
  end
end
