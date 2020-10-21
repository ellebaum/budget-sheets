require 'yaml'
require 'rubyXL'

def generate_actuals_yaml (input_path, output_path)
	path = input_path
	book = RubyXL::Parser.parse(path)
	actual_center_hash = YAML.load(File.read(output_path))

	budget_sheet = book[0]
	#####Budget Info##############################
	#SIM_Cost Center  -- Column C [2]
	#SIM_GL           -- Column E [4]
	#Actual(do later) -- Column G [6]

	actual_sheet = book['WF Actuals']
	#####Actual Info##############################
	#Cost Center      -- Column B [1]
	#Account Text     -- Column p [15]
	#Account Number   -- Column E [4]
	#Vendor Name      -- Column AC [28]
	#Vendor Number    -- Column R [17]
	#Currency         -- Column M [12]

	########Underlying data structure#############
	#actual_center_hash = {
	#	"center_1" => {
	#		"account_2 + acc_2_number" => {
	#			"vendor_2_name + vendor_2_number" => [500, 200000]
	#		}
	#	},
	#}
	#i.e., a hash of hashes of arrays

	if !actual_center_hash #if hash doesn't exist (why does it work this way?)
		actual_center_hash = Hash.new{|hsh, key| hsh[key] = Hash.new{|hsh2, key2| hsh2[key2] = Hash.new{|hsh3, key3| hsh3[key3] = []}}}
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
			account_text   = actual_sheet[index][15].value #Column P
			vendor_name    = actual_sheet[index][28].value #Column AC
			vendor_number  = actual_sheet[index][17].value #Column R
			currency       = actual_sheet[index][12].value #Column M
			#Default Cost Center is REDACTED1 if field is blank
			if cost_center.nil?
				cost_center = 'REDACTED1'
			end
			if vendor_name == ""
				vendor_name = "NO VENDOR NAME"
			end
			if vendor_number == ""
				vendor_number = "NO VENDOR NUMBER"
			end
			actual_center_hash[cost_center.to_s][account_text.to_s + " " + account_number.to_s][vendor_name.to_s + " " + vendor_number.to_s].push(currency)
		end
	end
	File.open(output_path, "w") { |file| file.write(actual_center_hash.to_yaml)}
end

def yaml_to_sqlite (yaml_file)
	hash1 = YAML.load_file(yaml_file)
	puts hash1.to_s

end



#generate_actuals_yaml('./file_name.xlsx', 'actuals.yaml')
yaml_to_sqlite('./actuals.yaml')
