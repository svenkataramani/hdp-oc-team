#!/bin/sh

start_date=$(date --date="14 days ago" +"%Y-%m-%d")
end_date=$(date --date="0 days ago" +"%Y-%m-%d")
echo $start_date
echo $end_date

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD

hive -hiveconf startdate=${start_date} -hiveconf enddate=${end_date} -f /home/hdp_oc_team/hivescripts/ProdEvents.HQL;

hadoop jar ${HOME}/tdch-1.4.2.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -nummappers 144 -separator "|" -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/prod_events -targettable  STG_PROD_EVENTS -nullnonstring "\N" -targetfieldnames "SHOPPER_ID,RESOURCE_ID,PROD_TYPE,EVENT_DATE_TXT,EVENT_ACTION";
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/ProdEvents.btq  
  
