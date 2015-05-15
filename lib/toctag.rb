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
           
      if mode == "current"
        # check for page in toc
        if not context.registers[:page]['toc']
          raise "This page does not belong a TOC collection"
        end
        pageData = context.registers[:page]
        
      else
        # find the collection with this name
        tocDat = context.registers[:site].data['toc']
        if tocDat and tocDat[mode]
          pageData = tocDat[mode]['root_doc'].data
        else
          raise "The TOC collection '#{mode}' could not be found"
        end
      end
      
      return renderTable(depth, pageData)
      
    end
    
    def createEntry(curDepth, p)
      "  "*(curDepth + 1) + "<li><a href=\"#{p.url}\"> #{p.data['toc']['nice_sec']}: #{p.data['title']}</a></li>\n"
    end
    
    def rec_process_entries(curDepth, maxDepth, pageData)
      if curDepth == maxDepth or not pageData.has_key?('toc') or pageData['toc']['children'].empty?
        return ""
      end
      
      str = "  "*(curDepth) + "<ul>\n"
      str << pageData['toc']['children'].map{ |p| createEntry(curDepth, p) + rec_process_entries(curDepth + 1, maxDepth, p.data) }.join("")
      str << "  "*(curDepth) + "</ul>\n"
      return str
      
    end
    
    def renderTable(depth, pageData)
      return rec_process_entries(0, depth, pageData)
    end
    
  end
end

Liquid::Template.register_tag('TOC', TOC::TableOfContentsTag)
