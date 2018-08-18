# Date 14 Aug 2018
#
# Postman REST API https://www.getpostman.com/
# Examples via Free version without a Postman account
#
# Postman documentation https://www.getpostman.com/docs/
# JavaScript based state machine REST API analysis tool
#
# Collection (Pre-request Script, Test Script)
#   Folder (Pre-request Script, Test Script)
#     Sub-Folder (Pre-request Script, Test Script)
#       Request (Pre-request Script, Test Script)
#
# v6.2.4 Request Execution
# https://www.getpostman.com/docs/postman/scripts/intro_to_scripts
# 1 Exec: Collection Pre-request Script
# 2 Exec: Folder Pre-request Script
# 3 Exec: Sub-Folder Pre-request Script
# 4 Exec: Request Pre-request Script
# 5 Exec: Send Request, Receive Response
# 6 Exec: Collection Tests
# 7 Exec: Folder Tests
# 8 Exec: Sub-Folder Tests
# 9 Exec: Request Tests
#
# Default rule is to executed each request from first to last
# https://www.getpostman.com/docs/postman/collection_runs/building_workflows
# postman.setNextRequest() - set the next request via "request name"

# Script Variables
# https://www.getpostman.com/docs/postman/environments_and_globals/variables
#   Global - String type variable that exist across scripts and collections
#          - set, used, updated via scripts
#            postman.setGlobalVariable("key","value") - in examples
#            pm.global.set("key","value")             - in examples
#            pm.global.get("key")
#            postman.getGlobalVariable("key")
#            globals.<key>  - in examples
#            globals["key"] - in examples
#
#   Collection - String type variable that exist only in collection
#              - Initial set via Collection's Variables key-value pairs
#              pm.variables.get("key") - in examples
#
#   Environment - String type variable that exist across scripts and collections
#               - Initial set via Environment's Variables key-value pairs
#               postman.setEnvironmentVariable("key","value")
#               pm.environment.set("key","value")
#               pm.environment.get("key")
#               postman.getEnvironmentVariable("key") - in examples
#               environment.<key>   - in examples
#               environment["key"]  - in examples
#
#   Local - Normal JavaScript type variable that exist only in script - in examples
#
#   Data  - import CSV or JSON file to iterate over collection
#
# Global, Collection, Environment - string to/from other types
#   Number() convert String to Number
#   toString() convert Array to String
#   join() convert from String to Array
#   JSON.parse() convert String to JSON Object
#   JSON.stringify() convert JSON Object to String
#
# JavaScript buit-in API (node packages)
# https://www.getpostman.com/docs/v6/postman/scripts/postman_sandbox_api_reference
# atob v2.0.3     Decodes a base-64 encoded string
# btoa v1.1.2     Encodes a string in base-64
# chai v3.5.0     BDD expect, should - in example
# cheerio v0.22.0 HTML parsing - in example
# crypto-js v3.1.9-1  crypto standards (md5, sha)
# csv-parse/lib/sync 1.2.1  CSV to arrays or objects
# lodash v4.17.4  Utilities: arrays, numbers, objects, strings, etc - in example
# moment v2.18.1 (sans locales) dates, times, zones, - in example
# postman-collection v1.2.0
# tv4 v1.2.7     JSON schema Validator - in example
# uuid           Universally Unique IDentifier 
# xml2js 0.4.19  XML to JavaScript converter
#
# Dish On-Line web site (TV Shows and Movies)
#
# Versions and status checks
# Web Site http://www.dishanywhere.com
# via API http radish.dishanywhere.com
#
# TV Shows sorts; filter by genres, ratings, letters
# Web page http://www.dishanywhere.com/ondemand/all/shows
# via REST API radish.dishanywhere.com/v20/dol/show
#
# Movies; sorts; filter by genres, ratings, letters
# Web page http://www.dishanywhere.com/ondemand/all/movies
# via REST API radish.dishanywhere.com/v20/dol/movies
#
# programs versions
# Postman v6.2.4
# newman v4.0.2
# ruby 2.4.1p111 (2017-03-22 revision 58053) [x64-mingw32]
# ruby gem json 2.1.0
# ruby gem csv 1.0.0
