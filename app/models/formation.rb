class Formation < ActiveRecord::Base
  belongs_to :cv

  before_save :sanitize_strings 

  def date_month
    return "" if self.date.nil?
    m = self.date.match /^.*\s/
    m.nil? ? "" : m.to_s.strip
  end

  def date_year
    return "" if self.date.nil?
    m = self.date.match /\d\d\d\d/
    m.nil? ? "" : m.to_s.strip
  end

end
