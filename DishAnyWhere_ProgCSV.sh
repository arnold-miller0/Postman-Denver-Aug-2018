#!/usr/bin/bash

# command line: run sample Postman script in Test Environment with
# generating command line out and junit xml report file
# report files are in created 'newman' sub-directory
# This report file will be the lasted created newman-run-report-*.xml

if [ "$#" -lt "1" ];
 then echo "$0" requires csv-convert-file
 exit -1
fi

test_name_base=DishAnyWhere_Programs
test_env_base=Dish_Prod_All
# test_env_base=Dish_Prod_sample
req_timeout=15000
postman_run=./$test_name_base.postman_collection.json
post_inp_env=./$test_env_base.postman_environment.json
postman_csv=./$1 # Dish_chg_vars.csv
post_out_env=./$test_env_base.postman_env_out.json

#ls -ltr $post_inp_env $postman_csv $post_out_env
ruby dish_postman_env_change.rb $post_inp_env $postman_csv "." $post_out_env 0 10 false
#ls -ltr $post_inp_env $postman_csv $post_out_env

junit_output=./output/${test_name_base}_${test_env_base}_junit.xml
sTime=`date`
newman run $postman_run -e $post_out_env -r junit,cli --timeout-request $req_timeout --color off
etime=`date`
echo "Postman start at $sTime"
echo "Postman ended at $etime"

postman_rst=`ls -tr ./newman/newman-run-report-*.xml | tail -1`
echo "JUnit XML report file:" $postman_rst
cp $postman_rst $junit_output
ls -l $postman_rst $junit_output
cksum $postman_rst $junit_output
echo Search \'AssertionFailure\' to find failures
