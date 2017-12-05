require "student/version"
require 'csv'

class Student
  @@all = []
  @@csv_file_read = false

  attr_reader :vorname, :nachname, :fhs, :mail
  def initialize(vorname:, nachname:, fhs:, mail:)
    @vorname = vorname
    @nachname = nachname
    @fhs = fhs
  end

  def self.all
    if @@csv_file_read == false
      raise "Die Konstante CSV_FILE mit dem Pfad/Namen der CSV-Datei muss gesetzt werden." unless CSV_FILE
      @@csv_file_read = true
      read_csv_file
    end
    @@all
  end

  def ein_vorname
    self.vorname.downcase.split(" ")[0]
  end

  def name
    "#{self.vorname} #{self.nachname}"
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


  private
  def self.read_csv_file
    CSV.foreach(CSV_FILE, {col_sep:";", encoding: "ISO8859-1", headers: true}) do |row|
      Student.all << Student.new(
        vorname: row['Vorname'],
        nachname: row['Nachname'],
        fhs: row['fhs'],
        mail: row['FH-Mailadresse']
      )
    end
  end
end
