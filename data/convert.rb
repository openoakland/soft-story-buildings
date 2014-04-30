#!/usr/bin/env ruby

# Convert an xls of soft story data into json 
# jayrbolton@gmail.com

require 'json'
require 'spreadsheet'
require 'date'

class Converter

  Keys = ['Property Address', 'Notified?', 'Status']

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
    return [Converter.extract_address(row), row[3], row[4]]
  end

  # Generate JSON from the Spreadsheet
  # sheet: Spreadsheet::Excel::Worksheet
  def rows_to_json(sheet)
    JSON.generate({:keys => Keys, :rows => sheet.drop(5).map{|r| extract_row(r)}})
  end

  # Extract the property address
  def self.extract_address(row)
    # row[0] - property address number
    # row[1] - property street name
    "#{row[0].to_i} #{Converter.titleize(row[1])}, Oakland, CA"
  end

  def self.titleize(str)
    str.nil? ? '' : str.gsub(/\w+/, &:capitalize)
  end

end

Converter.new(ARGV) if __FILE__ == $0
