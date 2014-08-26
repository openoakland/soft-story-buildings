#!/usr/bin/env ruby

# Convert an xls of soft story data into json 
# jayrbolton@gmail.com

require 'json'
require 'spreadsheet'
require 'date'
require 'geocoder'

Geocoder.configure({
  :lookup => :yandex,
  :timeout => 5
})

class Converter

  Keys = ['Property Address', 'Notified?', 'Status', 'Lat', 'Lng']

  # args: Array
  def initialize(args)
    filename = args.first
    if filename.nil? || !File.exist?(filename) || !File.readable?(filename)
      puts "usage: ./#{__FILE__} filename.xlsx > output.json" ; return
    end
    $stdout.print rows_to_json(init_sheet(filename))
    return self
  end
  
  # Initialize our Spreadsheet object
  # filename: String
  def init_sheet(filename)
    return Spreadsheet.open(filename).worksheet(0)
  end

  # Take an xls row and prune into a plain array
  # row: Spreadsheet::Excel::Row
  def extract_row(row)
    addr = Converter.extract_address(row)
    lat, lng = Converter.extract_geolocation(addr)
    return [addr, row[3], row[4], String(lat), String(lng)]
  end

  # Generate JSON from the Spreadsheet
  # sheet: Spreadsheet::Excel::Worksheet
  def rows_to_json(sheet)
    return JSON.generate({:keys => Keys, :rows => sheet.drop(5).map{|r| extract_row(r)}})
  end

  # Get geocoords from the address using Geocoder
  # addr: string
  def self.extract_geolocation(addr)
    location = Geocoder.search(addr).first
    if location && location.data && location.data['GeoObject']
      return location.data['GeoObject']['Point']['pos'].split(' ')
    else
      return ['','']
    end
  end

  # Extract the property address
  def self.extract_address(row)
    # row[0] - property address number
    # row[1] - property street name
    return "#{row[0].to_i} #{Converter.titleize(row[1])}, Oakland, CA"
  end

  def self.titleize(str)
    return str.nil? ? '' : str.gsub(/\w+/, &:capitalize)
  end

end

Converter.new(ARGV) if __FILE__ == $0
