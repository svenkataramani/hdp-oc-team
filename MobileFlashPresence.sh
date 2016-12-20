#!/bin/sh

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD
hadoop jar ${HOME}/tdch-1.4.2.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -batchsize 20000 -nummappers 24 -separator '\u0001' -sourcepaths /user/bkamble/bkamble.db/mobileflash_presence_july -targettable MobileFlash_Presence_July_STG -nullnonstring "\N" -nullstring "\N";
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/MobileFlashPresence.btq




