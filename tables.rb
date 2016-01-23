module Tables
  def self.behaviors
    [
      ["1 Respect & Humility", "Positive Only"],
      ["1 Respect & Humility", "Negative Only"],
      ["2 Integrity", "Positive Only"],
      ["2 Integrity", "Negative Only"],
      ["3 Passion", "Positive Only"],
      ["3 Passion", "Negative Only"],
      ["4 Perseverance", "Positive Only"],
      ["4 Perseverance", "Negative Only"],
      ["5 Empowerment", "Positive Only"],
      ["5 Empowerment", "Negative Only"],
      ["6 Team & Family", "Positive Only"],
      ["6 Team & Family", "Negative Only"],
      # ADD SUPPORT FOR THESE LATER
      # ["Double Penalties", "Negative Only"],
      # ["Notify Leadership Team", "Negative Only"]
      # ["Passes", "Negative Only"]
    ]
  end

  def self.months
    { 
      "01" => "Jan",
      "02" => "Feb",
      "03" => "Mar",
      "04" => "Apr",
      "05" => "May",
      "06" => "Jun",
      "07" => "Jul",
      "08" => "Aug",
      "09" => "Sep",
      "10" => "Oct",
      "11" => "Nov",
      "12" => "Dec"
    }
  end

  def self.headers
    ["Last Name", "First Name", "Grade", "R+", "R-", "I+", "I-", "Pa+", "Pa-", "Pe+", "Pe-", "E+", "E-", "T+", "T-"]
  end

  def self.files
     Dir["../raw_liveschool_data/*.csv"]
  end
end