#!/usr/bin/env ruby

# Convert an xls of soft story data into json 
# jayrbolton@gmail.com

require 'json'
require 'spreadsheet'
require 'date'

class Converter

  Keys = ['Property Address', 'Mailing Address', 'City & State', 'Postal Code', 'Category']

  # args: Array
  def initialize(args)
    filename = args.first
    if filename.nil? || !File.exist?(filename) || !File.readable?(filename)
      puts "usage: ./#{__FILE__} filename.xlsx > output.json" ; return
    end
    $stdout.print rows_to_json(init_sheet(filename))
  end
  
  # Initialize our Spreadsheet object
  # filename: String
  def init_sheet(filename)
    Spreadsheet.open(filename).worksheet(0)
  end

  # Take an xls row and prune into a plain array
  # row: Spreadsheet::Excel::Row
  def extract_row(row)
    return [
      Converter.format_address(row),
      row[8], # Status/Category
      Converter.format_date(row[6]) # Date
    ]
  end

  # Generate JSON from the Spreadsheet
  # sheet: Spreadsheet::Excel::Worksheet
  def rows_to_json(sheet)
    JSON.generate({:keys => Keys, :rows => sheet.drop(5).map{|r| extract_row(r)}})
  end

  def self.format_address(row)
    # row[0] - property address number
    # row[1] - property address street
    # row[4] - city and state
    # row[5] - zip
    "#{row[0].to_i} #{Converter.titleize(row[1])}, #{Converter.titleize(row[4])} #{row[5].to_i}"
  end

  def self.format_date(d)
    return 'Unknown' if d.nil?
    return 'Not notified yet' if d == 'NOTIFY'
    return d.strftime('%m/%d/%y') if d.is_a?(Date)
  end

  def self.titleize(str)
    str.nil? ? '' : str.gsub(/\w+/, &:capitalize)
  end

end

Converter.new(ARGV) if __FILE__ == $0
