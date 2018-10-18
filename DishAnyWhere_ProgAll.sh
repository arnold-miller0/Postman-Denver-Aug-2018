#!/usr/bin/bash

# command line: run sample Postman script in Test Environment with
# generating command line out and junit xml report file
# report files are in created 'newman' sub-directory
# This report file will be the lasted created newman-run-report-*.xml

test_name_base=DishAnyWhere_Programs
test_env_base=Dish_Prod_All
# test_env_base=Dish_Prod_sample
req_timeout=15000
postman_run=./$test_name_base.postman_collection.json
postman_env=./$test_env_base.postman_environment.json
junit_output=./output/${test_name_base}_${test_env_base}_junit.xml
sTime=`date`
newman run $postman_run -e $postman_env -r junit,cli --timeout-request $req_timeout
etime=`date`
echo "Postman start at $sTime"
echo "Postman ended at $etime"

postman_rst=`ls -tr ./newman/newman-run-report-*.xml | tail -1`
echo "JUnit XML report file:" $postman_rst
cp $postman_rst $junit_output
ls -l $postman_rst $junit_output
cksum $postman_rst $junit_output
echo Search \'AssertionFailure\' to find failures
