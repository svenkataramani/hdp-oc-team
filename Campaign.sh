#!/bin/sh

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD
hive -f /home/hdp_oc_team/hivescripts/Campaign.hql;
hadoop jar ${HOME}/tdch-1.4.2.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -nummappers 144 -separator "|" -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/campaign -targettable Campaign_STG -nullnonstring "\N" -targetfieldnames "shopper_id, campaign_id, campaign_name, audience_id, audience_description, treatment_id, treatment_name, inclusion_date";
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/Campaign.btq;