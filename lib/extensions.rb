# A ranger !!!
class String  
  require 'iconv'  
  def to_iso  
    c = Iconv.new('ISO-8859-15','UTF-8')  
    c.iconv(self)  
  end  
  
  def odt_convert
    self.gsub(/\&/, "&amp;")
  end
  
end

class NilClass
  def odt_convert
    nil
  end
end