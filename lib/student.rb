require "student/version"
require 'csv'

raise "Define a CSV_FILE variable with the path/filename of your CSV file " unless CSV_FILE 

class Student

  @@all = []
  attr_reader :vorname, :nachname, :fhs, :mail
  def initialize(vorname:, nachname:, fhs:, mail:)
    @vorname = vorname
    @nachname = nachname
    @fhs = fhs
  end

  def self.all
    @@all
  end

  def ein_vorname
    self.vorname.downcase.split(" ")[0]
  end

  def repository_url
    if self.fhs
      "https://gitlab.mediacube.at/#{self.fhs}/#{self.nachname.downcase}_#{self.ein_vorname.downcase}_db1"
    else
      ""
    end
  end

  def repo_pathname
    "#{self.nachname.downcase}_#{self.ein_vorname.downcase}_db1"
  end

end

CSV.foreach(CSV_FILE, {col_sep:";", encoding: "ISO8859-1", headers: true}) do |row|
  Student.all << Student.new(
    vorname: row['Vorname'],
    nachname: row['Nachname'],
    fhs: row['fhs'],
    mail: row['FH-Mailadresse']
  )
end
