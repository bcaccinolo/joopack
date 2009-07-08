# white_list is a simplification of the White List plugin to use this functionality in my controllers and models.
#
# You can use it anywhere in your rails app like that:
#
#   white_list @article.body
# 
def white_list(html)  
  tags = %w(strong em b i p code pre tt output samp kbd var sub sup dfn cite big small address hr br div span h1 h2 h3 h4 h5 h6 ul ol li dt dd abbr acronym a img blockquote del ins fieldset legend script)
  attributes = %w(href src width height alt cite datetime title class)
  
  return html if html.empty? || !html.include?('<')

  attrs   = Set.new(attributes)
  tags    = Set.new(tags)

  new_text = []

  tokenizer = HTML::Tokenizer.new(html)
  bad       = nil
  while token = tokenizer.next
          node = HTML::Node.parse(nil, 0, 0, token, false)
          new_text << case node
          when HTML::Tag
                  node.attributes.keys.each do |attr_name|
                          value = node.attributes[attr_name].to_s
                          if !attrs.include?(attr_name) || (protocol_attributes.include?(attr_name) && contains_bad_protocols?(value))
                                  node.attributes.delete(attr_name)
                          else
                                  node.attributes[attr_name] = CGI::escapeHTML(value)
                          end
                  end if node.attributes
                  
                  if tags.include?(node.name)
                          ""
                  else
                          token
                  end
          else
                token
          end
  end
  new_text.join('')
end

# The extension for ActiveRecord
class ActiveRecord::Base
  
  def sanitize_strings
    self.attribute_names.each { |att| 
      if (self[att].class == String)
        self[att] = white_list self[att]
      end
    }
  end
  
end



