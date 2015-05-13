module TOC
  class TableOfContentsTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      super
      @attributes = {}
      
      markup.scan(::Liquid::TagAttributes) do |key, value|
        @attributes[key] = value.gsub(/^'|"/, '').gsub(/'|"$/, '')
      end
      
      
    end

    def render(context)
      depth = @attributes.fetch("depth", "-1").to_i
      mode = @attributes.fetch("mode", "current")
    
      page = (mode == "global" ? context.registers[:site].data['toc']['root'].data : context.registers[:page] )
      
      return renderTable(depth, page)
    end
    
    def createEntry(curDepth, p)
      "<li><a href=\"#{p.url}\"> #{p.data['toc']['sec']} #{p.data['title']}</a></li>\n"
    end
    
    def rec_process_entries(curDepth, maxDepth, pageData)
      if curDepth == maxDepth or not pageData.has_key?('toc')
        return ""
      end
      
      str = ([ "<ul>" ] + pageData['toc']['children'].map{ |p| createEntry(curDepth, p) + rec_process_entries(curDepth + 1, maxDepth, p.data) } + ["</ul>"]).join("")     
      return str
      
    end
    
    def renderTable(depth, pageData)
      return rec_process_entries(0, depth, pageData)
    end
    
  end
end

Liquid::Template.register_tag('TOC', TOC::TableOfContentsTag)
