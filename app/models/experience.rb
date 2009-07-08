class Experience < ActiveRecord::Base
  
  belongs_to :cv

  before_save :sanitize_strings 
  
  def begin_month
    return "" if self.begin.nil?
    m = self.begin.match /^.*\s/
    m.nil? ? "" : m.to_s.strip
  end

  def begin_year
    return "" if self.begin.nil?
    m = self.begin.match /\d\d\d\d/
    m.nil? ? "" : m.to_s.strip
  end

  def end_month
    return "" if self.end.nil? or self.end == "IN_POST"
    m = self.end.match /^.*\s/
    m.nil? ? "" : m.to_s.strip
  end

  def end_year
    return "" if self.end.nil? or self.end == "IN_POST"
    m = self.end.match /\d\d\d\d/
    m.nil? ? "" : m.to_s.strip
  end

  def in_post
    return "1" if self.end == "IN_POST"
    return "0"
  end
  
  def text_end
    if self.end == "IN_POST"
      "En poste"
    else
      self.end
    end
  end

end
