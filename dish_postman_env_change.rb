#require 'digest'   # MD5 , RMD160, SHA1, SHA2; gem digest 0.0.1
require 'json'     # JSON format parse and buld; gem json 2.1.0
#require 'httparty' # HTTP methods; gem httparty 0.15.6
require 'csv'      # CSV format and files; gem csv 1.0.0
require 'uri'      # URI for HTTP comamnds and args; in ruby v2.1

def checkFileParams (full_path, start, stop)
   puts "  open input  file #{full_path}"
   if not (File.exist? full_path)
    puts "  convertion variable file: #{full_path} does not exist"
    return false
  end

  if (start < 0 || stop < 0 || start > stop)
    puts "  Either start row #{start} negative; or Stop row #{stop} negative; or start row after stop row"
    return false
  end
  return true
end

def chkInputJsonFile (full_path)
  if not (File.exist? full_path)
    puts "  input Json file: #{full_path} does not exist"
    return false
  else
    return true
  end
end

def chkExistsResultFile (fullResPath)
  if not (File.exist? fullResPath)
    puts "  create diff result file: #{fullResPath} as not exist"
    File.new(fullResPath, File::CREAT|File::TRUNC|File::RDWR )
  end
end

# main function to get any eval auto-complete (suggest) Radish events
def changePostEnvValue (
  inputFile,      # input Postman enviroment file (JSON format)
  csvChgFile,     # csv file that containt variable, value
  rsltDirectory,  # directory to write the result file
  outputFile,     # output Postman envirment file after changing variable values
  start=0,        # staring change row - not implemented yet
  stop=1,         # ending change row - not implemented yet
  printInfo=true  # debug print flag - not implemented yet
  )
  puts "Start convert postname env file"

  # check that Input file and args are good
  fullInputPath = File.absolute_path inputFile
   if not (chkInputJsonFile fullInputPath )
    return
  end
  puts "  Input EnvFile: #{inputFile};"
  fullcsvChgPath = File.absolute_path csvChgFile
   if not (checkFileParams fullcsvChgPath, start, stop )
    return
  end
  puts "  Change CSV File: #{csvChgFile};"
  # set varibales to process specified row in file
  num = stop-start+1

  fullResultPath = File.absolute_path(outputFile, rsltDirectory)
  chkExistsResultFile fullResultPath
  puts "  Output File: #{outputFile};"
  chgPostEnvFP = File.open(fullResultPath,"w")

  fullInput = File.read(fullInputPath)
  jsonInput = JSON.parse(fullInput)

  jsonOutput  = jsonInput
  jsonValueList = jsonInput["values"]

  chg_var_offset = 1     # offset to variable
  chg_val_offset = 2     # offset to value

  begin
    CSV.open(fullcsvChgPath, 'r') do |fi|
      infos = fi.each

      puts "  skip    #{start} rows" if printInfo
      start.times {infos.next}

      puts "  process #{num} rows" if printInfo
      count = start

      num.times do
        rowData = infos.next
        chgVar = rowData[chg_var_offset]
        chgVal = rowData[chg_val_offset]
        if count == 0
          puts "  Row #{count}: Header row: '#{chgVar}' value: '#{chgVal}'"
        else
          puts "  Row #{count}: Change var: '#{chgVar}' value: '#{chgVal}'"
          found = false;
          jsonValueList.each do | valObj |
            if valObj["key"] == chgVar
              puts "  found variable key '#{chgVar}'"
              found = true;
              valObj["value"] = chgVal
              break
            end
          end
          puts "  not found variable key '#{chgVar}'" if (not (found))
        end
        count += 1
      end
    end
    rescue EOFError
    rescue StopIteration
  end
  jsonOutput["values"] = jsonValueList

  chgPostEnvFP.puts JSON.pretty_generate(jsonOutput)
  puts "Done  convert postname env file"
end
#changePostEnvValue("Dish_Prod_All.postman_env.json","Dish_chg_vars.csv",".","Dish_Prod_All.postman_out.json",0,10,true)

#  processing command line args
inArray = ARGV

for c in 0..inArray.length
  puts "arg #{c} is: #{inArray[0]}" if (inArray.length > 6 && inArray[6] == "true")
end
changePostEnvValue( inArray[0], inArray[1], inArray[2], inArray[3], inArray[4].to_i, inArray[5].to_i, (inArray[6]=="true") )
