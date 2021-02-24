module ApplicationHelper
  include ERB::Util

  def auth_token
    "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\">".html_safe
  end

  def patch_method
    "<input type=\"hidden\" name=\"_method\" value=\"patch\">".html_safe
  end

  def render_flash_messages
    html = ""
    flash.each do |type, msgs|
      msgs.each do |msg|
        html += "<div class=\"#{type}\">#{msg}.</div>"
      end
    end
    html.html_safe
  end

  def ugly_lyrics(lyrics)
    formatted_lyrics = ""
    lyrics.lines.each do |line|
      formatted_lyrics << "&#9835; #{h(line)}"
    end

    "<pre>#{formatted_lyrics}</pre>".html_safe
  end
end
