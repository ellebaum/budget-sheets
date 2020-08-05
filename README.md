# budget-sheets
Scripts to help with spreadsheeting!

## Installing WSL on Windows 10
1. Navigate to Control Panel -> Programs -> Turn Windows features on or off
2. Turn on "Windows Subsystem for Linux"
3. Reboot PC
4. Navigate to the Microsoft Store
5. Search for 'ubuntu', then 'get' Ubuntu 20.04 LTS
6. Click on 'Launch' to install Ubuntu
7. Choose username and password

## Installing Ruby on WSL
1. Type 'sudo apt update && sudo apt dist-upgrade && sudo apt autoremove && sudo apt clean' (without quotes) in the terminal
2. Type 'sudo apt install ruby-full'
3. Type 'sudo gem install rubyXL' (google the error and follow directions for the stuff nokogiri needs)
4. *In Windows*, create a folder called 'unbutu' on c: (or whichever disk drive)
5. type 'cd /mnt/c/ubuntu'
6. type 'git clone [repo url]'

## Using the script
1. From Windows, launch Ubuntu (Windows Key -> search "ubuntu")
2. In the terminal, type 'cd /mnt/c/unbuntu/budget-sheets' ('cd' means 'change directory')
- type 'ls' (list) to view directory contents
- type 'pwd' (print working directory) to see which directory you're in
3. In Windows, create a copy the spreadsheet into c:\unbuntu\budget-sheets
4. In Windows, create an output file (ex: output.yaml) in c:\ubuntu\budget-sheets
- Note that the output file **must be empty**
5. Open c:\ubuntu\budget-sheets\spreadsheet-tools.rb a text editor (ex: Sublime Text)
6. Scroll to the bottom of the file (where it says "Call Functions Below Here")
7. Use the functions according to the format in the comments (lines starting with a # are commented, meaning you can read them but they will not execute as code)
8. Save the file
9. In the terminal, type 'ruby spreadsheet-tools.rb'
- If it's taking too long, type CTRL + C in the terminal to stop the process
10. Open the output file when the script says it's done!
