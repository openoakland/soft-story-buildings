#!/usr/bin/env ruby

# Convert an xls of soft story data into json 
# jayrbolton@gmail.com

require 'json'
require 'spreadsheet'

class Converter

	Keys = ['Property Address', 'Mailing Address', 'City & State', 'Postal Code', 'Category']

	# args: Array
	def initialize(args)
		filename = args.first
		if filename.nil? || !File.exist?(filename) || !File.readable?(filename)
			puts "usage: ./#{__FILE__} filename.xlsx > output.json" ; return
		end
		$stdout.print parse_rows(init_sheet(filename))
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
			"#{row[0].to_i} #{Converter.titleize(row[1])}, #{Converter.titleize(row[4])}", # Property address
			row[5].to_i, # Postal Code
			row[8] # Category
		]
	end

	# Generate JSON from the Spreadsheet
	# sheet: Spreadsheet::Excel::Worksheet
	def parse_rows(sheet)
		JSON.generate({:keys => Keys, :rows => sheet.drop(5).map{|r| extract_row(r)}})
	end

	def self.titleize(str)
		str.nil? ? '' : str.gsub(/\w+/, &:capitalize)
	end

end

Converter.new(ARGV) if __FILE__ == $0
