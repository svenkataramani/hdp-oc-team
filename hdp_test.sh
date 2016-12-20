#!/bin/sh

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD
hive -f /home/hdp_oc_team/hivescripts/hdp_test/hdp_test.hql;
hadoop jar ${HOME}/tdch-1.1.1.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -method multiple.fastload -batchsize 20000 -separator "|" -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/hdp_test -targettable  HDP_TEST_STG  -nullnonstring "\N" -targetfieldnames "domain_id, domain_name, parent_resource_id, unique_id, gdshop_product_typeid, add_on_resource_id, order_date, cancel_date, order_id, row_id,bundle_flag"; 
bteq -c ASCII 16/home/hdp_oc_team/bteqscripts/hdp_test.btq;

