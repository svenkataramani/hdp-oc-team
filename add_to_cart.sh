kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD


# yesterday's date
yesterday_date=$(date --date="yesterday" +"%Y-%m-%d")

# create current date
current_date=$(date --date="today" +"%Y-%m-%d")

echo $current_date
echo $yesterday_date

# run hive script

# hive -hiveconf current_date=${current_date} -f /home/hdp_oc_team/test/add_to_cart_stg.hql;




hive -f /home/hdp_oc_team/hivescripts/hdp_test/add_to_cart_stage.hql;
hadoop jar ${HOME}/tdch-1.4.2.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -nummappers 144 -separator "|" -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/add_to_cart_stage -targettable  add_to_cart_stg  -nullnonstring "\N" -targetfieldnames "cart_date, shopper_id, vguid, domain_name, cart_tld_name"; 
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/add_to_cart.btq;















########################################################################################################