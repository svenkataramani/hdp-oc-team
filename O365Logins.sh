#!/bin/sh

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD
# remove HDFS files 
hive -f /home/hdp_oc_team/hivescripts/O365Logins.hql;
hadoop jar ${HOME}/tdch-1.4.2.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -nummappers 144 -separator '\u0001' -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/O365Logins -targettable  STG_O365_LOGINS -nullnonstring "\N";
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/O365Logins.btq