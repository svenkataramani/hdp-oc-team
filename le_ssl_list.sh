#!/bin/sh

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD
##hive -f /home/hdp_oc_team/hivescripts/le_ssl_list.hql;
hadoop jar ${HOME}/tdch-1.1.1.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -method multiple.fastload -batchsize 20000 -separator "|" -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/le_ssl_list -targettable  le_ssl_list_STG  -nullnonstring "\N" -targetfieldnames "ct_subdomain, issuer_cn, ct_exp_date, cl_subdomain, ct_issue_date, gd_subdomain, gd_issue_date, gd_exp_date, cancel_date, order_id, row_id, shopper_id"; 
bteq -c ASCII 16/home/hdp_oc_team/bteqscripts/le_ssl_list.btq;





       