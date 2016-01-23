require 'chronic'

module Friday
  def self.last_friday
    Chronic.parse("last friday")
  end

  def self.month
    last_friday.month.to_s.rjust(2, "0")
  end

  def self.day
    last_friday.day.to_s.rjust(2, "0")
  end
end