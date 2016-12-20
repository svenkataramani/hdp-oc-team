#!/bin/sh

hive -f /home/hdp_oc_team/hivescripts/shopperdelegation.hql;
hadoop jar ${HOME}/tdch-1.4.2.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -nummappers 144 -separator "|" -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/shopperdelegation -targettable  shopperdelegation_STG  -nullnonstring "\N" -targetfieldnames "shopper_id, grantee_shopper_id, delegationlevelid, isactive, createdate, modifydate"; 
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/shopperdelegation.btq;


