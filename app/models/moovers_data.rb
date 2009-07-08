class MooversData < ActiveRecord::Base
  
  belongs_to :cv

  before_save :sanitize_strings 

  def perso_data_empty?    
    att_list = attribute_names
    att_list.delete("cv_title")
    att_list.delete("id")
    att_list.delete("user_id")
    att_list.each { |att|
      unless self[att].nil? # or self[att].empty?
        return false
      end
    }
    true
  end

  def age
    # select round((to_days(now()) - to_days(birthdate)) / 365.24)  from moovers_datas where id = 1;
    p = ActiveRecord::Base.connection.execute(" select FLOOR((to_days(now()) - to_days(birthdate)) / 365.24)  from moovers_datas where id = #{id};") 
    p.fetch_row.first
  end

  def birth_day 
    return "" if self.birthdate.nil?
    self.birthdate.day
  end
  
  def birth_month
    return "" if self.birthdate.nil?
    self.birthdate.month
  end
  
  def birth_year
    return "" if self.birthdate.nil?
    self.birthdate.year.to_s
  end
  
  def generate_birth_date(attributes)
    date = "#{attributes['birth_year']}-#{attributes['birth_month']}-#{attributes['birth_day']}"
    attributes[:birthdate] = date
    attributes.delete 'birth_year'
    attributes.delete 'birth_month'
    attributes.delete 'birth_day'
    attributes
  end
  
end
