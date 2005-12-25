# $Id: hiki_formatter.rb,v 1.7 2005-09-30 11:53:15 fdiary Exp $
# Copyright (C) 2003 TAKEUCHI Hitoshi <hitoshi@namaraii.com>

module Hiki
  class HikiFormatter
    H2_RE = /^<h2>.*<a name=/
    
    def apply_tdiary_theme(orig_html)
      return orig_html if @conf.mobile_agent?
      section = ''
      title   = ''
      html    = ''

      orig_html.each do |line|
        if H2_RE =~ line
          html << tdiary_section(title, section) unless title.empty? && section.empty?
          section = ''
          title = line
        else
          section << line
        end
      end
      html << tdiary_section(title, section)
    end

    private

    def tdiary_section(title, section)
      title = title.strip
      section = section.strip
      return '' if title.empty? && section.empty?
<<"EOS"
<div class="day">
  #{title}
  <div class="body">
    <div class="section">
      #{section}
    </div>
  </div>
</div>
EOS
    end
  end
end