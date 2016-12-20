#!/bin/sh

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD
# remove HDFS files 
# hadoop fs -rm /user/hdp_oc_team/data/UpcomingMUExpOutput/*;
# hadoop fs -rmdir /user/hdp_oc_team/data/UpcomingMUExpOutput;
# hive -e 'use hdp_oc_team; truncate table do_manual_renewals;';
# hive -e 'use hdp_oc_team; insert into table do_manual_renewals select shopper_id, resource_id, expiration_date from bisandbox.renewal_raw WHERE to_date(expiration_date) between date_add(to_date(from_unixtime(unix_timestamp())), 1) and date_add(to_date(from_unixtime(unix_timestamp())), 30) and renewal_order_id is null and (auto_renewal_flag = 0 or auto_renewal_flag is null) group by shopper_id, resource_id, expiration_date;';
# pig -useHCatalog -f /home/hdp_oc_team/pigscripts/UpcomingManualRenewExpirations.pig;
# hadoop jar ${HOME}/tdch-1.1.1.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username doritijr -password gambino1 -jobtype hdfs -fileformat textfile -method multiple.fastload -batchsize 20000 -separator "," -sourcepaths /user/hdp_oc_team/data/UpcomingMUExpOutput -targettable  ShopMnlRenew_STG -targetfieldnames "ShopAcctID,Resource_ID,expiration_date_txt";
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/UpcomingManualRenewExpirations.btq;