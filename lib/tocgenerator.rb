require 'set'

class String
  def humanize
    str = sub(/^[0-9]*_/, '').sub("_", " ")
    return str[0].upcase + str[1..-1]
  end
end

module TOC
  TOC_TYPE = "toc_type"
  TOC_OVERVIEW = "overview"
    
  def self.positionsToString(positions)
    return positions.map{|i| i.to_s + "."}.join("")
  end
  
  class TOC_Page < Jekyll::Page
    def initialize(site, base, dir, name, title)
      @site = site
      @base = base
      @dir = dir
      @name = name
      
      template = site.data['toc']['auto_generated']['template']
      
      self.process(@name)
      self.read_yaml(File.join(base, '_templates'), template )
      
      self.data['title'] = title     
    end
  end
  

  class TOCGenerator < Jekyll::Generator
    @collection
      
    def extractValidIDEnum(doc)
      keys = doc.relative_path.sub(/^_#{@collection}\//, '').split("/")
      
      if doc.data.fetch(TOC_TYPE, "") == TOC_OVERVIEW
        return keys[0 .. -2]
      else
        return keys
      end
    end
    
    
    def createOverviewPage(site, key)
      file_pos = File.join(@collection, key.join("/"))
      file_name = site.data['toc']['auto_generated']['filename']
      
      title = key.empty? ? site.data['toc']['auto_generated']['root_title'] : key[-1].humanize
      
      page = TOC_Page.new(site, site.source, file_pos, file_name, title)
      site.pages << page      
      
      return page
    end
    
    def createPosMap(sortedKeys)
      cur = Array.new(sortedKeys[0].length, 1)
      lst = [cur]
      
      for i in (1 ... sortedKeys.length)
        prevKey = sortedKeys[i-1]
        curKey = sortedKeys[i]
        cur = cur.clone
               
        if prevKey.length == curKey.length
          # increase final counter
          cur[-1]+= 1
        elsif prevKey.length < curKey.length
          # add a new level
          cur << 1
        elsif prevKey.length > curKey.length
          # remove a level
          cur = cur[0 .. -2]
          cur[-1] += 1
        end
        lst << cur
      end
        return lst
    end
    
    def generate(site)
      @collection = site.data['toc']['collection']
    
      # dictionary with all the keys and conforming docs
      keyToDoc = Hash[ site.collections[@collection].docs.map { |doc| [extractValidIDEnum(doc), doc] }.to_a ]
      # array of all possible keys
      reqKeys = Set.new( keyToDoc.keys.flat_map{ |key|  (0 .. key.length).map { |i| key[0 ... i] } } )
      
      # new overview pages added if necessary
      reqKeys.select { |key| not keyToDoc.has_key? key }.each { |key| keyToDoc[key] = createOverviewPage(site, key) }
      
      # sorted keyset
      sortedKeys = keyToDoc.keys.map.sort { |a,b| a.join("/") <=> b.join("/")}
      
      # the positions for each key
      positions = createPosMap(sortedKeys)
      
      sortedKeys.each_with_index do |keys, i|
        pos = positions[i]
        sec = TOC.positionsToString(pos)
        next_doc = keyToDoc.fetch(sortedKeys.at(i+1), nil)
        prev_doc = i == 0 ? nil : keyToDoc[sortedKeys.at(i-1)]
        up_doc = keyToDoc.fetch( keys[0..-2], nil )
        child_docs = sortedKeys.select { |k| k.length == keys.length + 1 and k[0 .. -2] == keys}.map { |k| keyToDoc[k] }
        
        # set the data
        doc = keyToDoc[keys]
        doc.data['toc'] = { "pos" => pos, "sec" => sec, "next" => next_doc, "prev" => prev_doc, "up" => up_doc, "children" => child_docs }
      end
      
      site.data['toc'] = { "root" => keyToDoc[sortedKeys[0]] }
    end
  end
end
