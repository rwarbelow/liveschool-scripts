require 'capybara'
require 'selenium-webdriver'
require 'csv'

require_relative 'friday'
require_relative 'student'
require_relative 'student_repository'
require_relative 'tables'

username = ENV["LIVESCHOOL_USERNAME"]
password = ENV["LIVESCHOOL_PASSWORD"]

capybara = Capybara

capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.dir'] = "~/Desktop/liveschool_scripts"
  profile['browser.download.folderList'] = 2
  profile['browser.helperApps.neverAsk.saveToDisk'] = "application/csv"
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

capybara.current_driver = :selenium

capybara.visit "https://admin.p2.liveschoolinc.com/exports"
capybara.fill_in("username", with: username)
capybara.fill_in("password", with: password)
capybara.find(".black_button").click
capybara.select("Behavior", from: "export_stat")
Tables.behaviors.each do |behavior|
  capybara.select(behavior.first, from: "export_standard")
  capybara.select(behavior.last, from: "export_behavior_type")
  capybara.select(Tables.months[Friday.month], from: "export_start[1]")
  capybara.select(Friday.day, from: "export_start[2]")
  sleep(1)
  capybara.click_on("Download")
end

student_repository = StudentRepository.new
student_repository.import_behavior_data_from(Tables.files)

CSV.open('result.csv','w') do |csv|
  csv << Tables.headers
  student_repository.students.each do |student|
    csv << student.row_format
  end
end