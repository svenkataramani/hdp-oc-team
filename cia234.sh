#!/bin/sh

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD
##hive -f /home/hdp_oc_team/hivescripts/hdp_test/cia234_list.hql;
hadoop jar ${HOME}/tdch-1.1.1.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -method multiple.fastload -batchsize 20000 -separator "|" -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/cia234_list_stg -targettable  cia234_list_stg  -nullnonstring "\N" -targetfieldnames "shopper_id, first_name, last_name, phone1, shopper_group, sms_optin, email_optin, call_optin, min_expdate, max_expdate"; 
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/cia234.btq;




