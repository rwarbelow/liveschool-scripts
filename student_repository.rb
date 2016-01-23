class StudentRepository
  attr_accessor :students

  def initialize
    @students = []
  end

  def import_behavior_data_from(files)
    date_key = CSV.read(files.first, 'r', headers: true, skip_lines: /Behavior Instances/).first.to_h.keys.last
    files.each do |file|
      file_name = CSV.open(file, 'r') { |csv| csv.first }.first
      puts "Importing #{file_name}."
      file_words = file_name.split(" ")
      behavior_type = "#{file_words[-3]} #{file_words[-2]}".gsub("(", "").downcase.gsub!(" ", "_")
      CSV.read(file, 'r', headers: true, skip_lines: /Behavior Instances/).each do |student|
        add_data_for(behavior_type, student, date_key)
      end
    end
  end

private

  def add_student(student_data)
    student = Student.new(student_data)
    @students << student
    student
  end

  def add_data_for(core_value, student_data, date_key)
    find_student_by(student_data).instance_variable_set("@#{core_value}", student_data[date_key])
  end

  def find_student_by(student_data)
    student = @students.find do |student|
      student.unique_identifier == "#{student_data['First Name']} #{student_data['Last Name']} #{student_data['Grade']}"
    end
    student = add_student(student_data) unless student
    student
  end
end
