require 'yaml'
require 'rubyXL'

def generate_actuals_yaml (input_path, output_path)
	path = input_path
	book = RubyXL::Parser.parse(path)
	actual_center_hash = YAML.load(File.read(output_path))
	puts actual_center_hash
	budget_sheet = book[0]
	#####Budget Info##############################
	#SIM_Cost Center  -- Column C [2]
	#SIM_GL           -- Column E [4]
	#Actual(do later) -- Column G [6]
	actual_sheet = book['WF Actuals']
	#####Actual Info##############################
	#Cost Center      -- Column B [1]
	#Account Number   -- Column E [4]
	#Currency         -- Column M [12]
	########Underlying data structure#############
	#actual_center_hash = {
	#		"account_1" => [100, 200, 300, 400],
	#	"center_1" => {
	#		"account_2" => [500, 200000]
	#	},
	#	"center_2" => {
	#		"account_1" => [9999, 6000, 25],
	#		"account_50" => [5, 90, 450]
	#	},
	#	"center_3" => {
	#		"account_2" => [670, 890, 2000],
	#		"account_35" => [299, 68001, 8]
	#	}
	#}
	#i.e., a hash of hashes of arrays
	if !actual_center_hash #if hash doesn't exist (why does it work this way?)
		actual_center_hash = Hash.new{|hsh,key| hsh[key] = Hash.new{|hsh2,key2| hsh2[key2] = []}}
	else
		old_actuals_hash = actual_center_hash.dup #to eliminate duplicate entries
	end
	actual_sheet.each_with_index do |row, index|
		if index > 3 #start on row #5
			if index % 100 == 0
				puts "On row #" + index.to_s + "..."
			end
			cost_center    = actual_sheet[index][1].value  #Column B
			account_number = actual_sheet[index][4].value  #Column E
			currency       = actual_sheet[index][12].value #Column M
			#Default Cost Center is 37000000 if field is blank
			if cost_center.nil?
				cost_center = '37000000'
			end
			actual_center_hash[cost_center][account_number].push(currency)
		end
	end
	File.open(output_path, "w") { |file| file.write(actual_center_hash.to_yaml)}
end

generate_actuals_yaml('./sample.xlsx', 'actuals.yaml')