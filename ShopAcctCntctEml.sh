#!/bin/sh


kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD

###############################################
# create parameters (first of two date ranges)
###############################################

process_start_timestamp=$(date --date="today" +"%Y-%m-%d %H:%M")

# create current date
current_date=$(date --date="today" +"%Y-%m-%d")

process_finish_timestamp=$(date --date="today" +"%Y-%m-%d %H:%M")

###############################################
# end create parameters
###############################################


echo 'processing parameters used:'
echo $current_date

########################################################################################################

hive -hiveconf current_date=${current_date} -f /home/hdp_oc_team/hivescripts/ShopAcctCntctEml.hql;
hadoop jar ${HOME}/tdch-1.4.2.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -nummappers 144 -separator "|" -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/shopacctcntcteml -targettable ShopAcctCntctEml_STG;
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/ShopAcctCntctEml.btq

echo 'process started:' ${process_start_timestamp}
echo 'process completed:' ${process_finish_timestamp}

exit;