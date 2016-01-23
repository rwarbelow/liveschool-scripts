class Student
  attr_accessor :last_name, 
                :first_name,
                :grade,
                :humility_positive,
                :humility_negative,
                :integrity_positive,
                :integrity_negative,
                :passion_positive,
                :passion_negative,
                :perseverance_positive,
                :perseverance_negative,
                :empowerment_positive,
                :empowerment_negative,
                :family_positive,
                :family_negative

  def initialize(data)
    @first_name = data["First Name"]
    @last_name  = data["Last Name"]
    @grade      = data["Grade"]
  end

  def unique_identifier
    "#{first_name} #{last_name} #{grade}"
  end

  def row_format
    [
      last_name, 
      first_name, 
      grade, 
      humility_positive, 
      humility_negative,
      integrity_positive, 
      integrity_negative, 
      passion_positive, 
      passion_negative,
      perseverance_positive, 
      perseverance_negative, 
      empowerment_positive, 
      empowerment_negative,
      family_positive, 
      family_negative
    ]
  end
end