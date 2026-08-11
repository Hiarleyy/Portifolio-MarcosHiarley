# Custom Redcarpet renderer that uses Rouge for syntax highlighting
# Place this in app/lib or config/initializers
class MarkdownRenderer < Redcarpet::Render::HTML
  def block_code(code, language)
    language = language.presence || "text"

    begin
      lexer = Rouge::Lexer.find_fancy(language, code) || Rouge::Lexers::PlainText.new
      formatter = Rouge::Formatters::HTML.new
      highlighted = formatter.format(lexer.lex(code))

      <<~HTML
        <div class="code-block">
          <div class="code-header">
            <span class="code-lang">#{language}</span>
            <button class="code-copy-btn" onclick="navigator.clipboard.writeText(this.closest('.code-block').querySelector('code').innerText)">
              <i class="ph ph-copy"></i> Copiar
            </button>
          </div>
          <pre class="highlight #{language}"><code>#{highlighted}</code></pre>
        </div>
      HTML
    rescue StandardError
      "<pre class=\"highlight\"><code>#{CGI.escapeHTML(code)}</code></pre>"
    end
  end

  def header(text, header_level)
    id = text.downcase.gsub(/[^a-z0-9\-_ ]/, "").strip.gsub(/\s+/, "-")
    "<h#{header_level} id=\"#{id}\" class=\"prose-heading\">#{text}</h#{header_level}>\n"
  end

  def link(link, title, content)
    title_attr = title ? " title=\"#{title}\"" : ""
    external = link&.start_with?("http") ? " target=\"_blank\" rel=\"noopener noreferrer\"" : ""
    "<a href=\"#{link}\"#{title_attr}#{external}>#{content}</a>"
  end

  def image(link, title, alt)
    title_attr = title ? " title=\"#{title}\"" : ""
    "<figure class=\"prose-figure\"><img src=\"#{link}\" alt=\"#{alt}\"#{title_attr} loading=\"lazy\"><figcaption>#{alt}</figcaption></figure>"
  end

  def table(header, body)
    "<div class=\"prose-table-wrapper\"><table class=\"prose-table\"><thead>#{header}</thead><tbody>#{body}</tbody></table></div>"
  end

  def block_quote(quote)
    "<blockquote class=\"prose-quote\">#{quote}</blockquote>"
  end

  def hrule
    "<hr class=\"prose-divider\">"
  end
end
