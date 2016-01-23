require 'capybara'
require 'selenium-webdriver'
require 'csv'
require 'dotenv'

require_relative 'friday'
require_relative 'student'
require_relative 'student_repository'
require_relative 'tables'

Dotenv.load

username = ENV["LIVESCHOOL_USERNAME"]
password = ENV["LIVESCHOOL_PASSWORD"]

capybara = Capybara

capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.dir'] = "~/Desktop/raw_liveschool_data"
  profile['browser.download.folderList'] = 2
  profile['browser.helperApps.neverAsk.saveToDisk'] = "application/csv"
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

session = Capybara::Session.new(:selenium)

session.visit "https://admin.p2.liveschoolinc.com/exports"
session.fill_in("username", with: username)
session.fill_in("password", with: password)
session.find(".black_button").click
session.select("Behavior", from: "export_stat")
Tables.behaviors.each do |behavior|
  session.select(behavior.first, from: "export_standard")
  session.select(behavior.last, from: "export_behavior_type")
  session.select(Tables.months[Friday.month], from: "export_start[1]")
  session.select(Friday.day, from: "export_start[2]")
  sleep(1)
  session.click_on("Download")
end

student_repository = StudentRepository.new
student_repository.import_behavior_data_from(Tables.files)

CSV.open("../behavior_totals_#{Date.today}.csv",'w') do |csv|
  csv << Tables.headers
  student_repository.students.each do |student|
    csv << student.row_format
  end
end