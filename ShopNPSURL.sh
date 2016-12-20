#!/bin/sh

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD
hive -f /home/hdp_oc_team/hivescripts/ShopNPSURL.hql;
hadoop jar ${HOME}/tdch-1.4.2.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -nummappers 144 -separator '\u0001' -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/shopnpsurl -targettable ShopNPSURL_STG -nullnonstring '\N' -nullstring '\N';
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/ShopNPSURL.btq;