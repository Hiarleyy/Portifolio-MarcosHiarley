module ApplicationHelper
  # Renders a Markdown string as safe HTML with Rouge syntax highlighting
  def markdown(text)
    return "" if text.blank?

    renderer = MarkdownRenderer.new(
      filter_html: false,
      hard_wrap: false,
      link_attributes: { target: "_blank", rel: "noopener noreferrer" }
    )

    options = {
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      strikethrough: true,
      highlight: true,
      footnotes: true,
      superscript: true,
      no_intra_emphasis: true,
      space_after_headers: true,
      underline: true,
      quote: true
    }

    markdown_parser = Redcarpet::Markdown.new(renderer, options)
    html = markdown_parser.render(text)
    html.html_safe
  end
end
