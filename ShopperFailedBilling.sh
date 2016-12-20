#!/bin/sh

kinit -R -k -t /home/hdp_oc_team/kerberos/hdp_oc_team.keytab hdp_oc_team@DC1.CORP.GD
hive -f /home/hdp_oc_team/hivescripts/ShopperFailedBilling.hql;
hadoop jar ${HOME}/tdch-1.4.2.jar com.teradata.hadoop.tool.TeradataExportTool -classname com.teradata.jdbc.TeraDriver -url jdbc:teradata://godaddy3.prod.phx3.gdg/DATABASE=P_HadoopImp_S -username P_BTCH_HadoopImp -password P_BTCH_HadoopImp -jobtype hdfs -fileformat textfile -nummappers 144 -separator "|" -nullnonstring "\N" -sourcepaths /user/hdp_oc_team/hdp_oc_team.db/do_shopperfailedbilling -targettable ShopFailBlg_STG -targetfieldnames "gdsBillResrcHistId, shopper_id, date_entered, order_id, row_id, resource_id, gdshop_billing_attemptid, adjusted_price, gdshop_product_typeid, cpl_id, billing_attempt, response_code, reason_code, source, billing_country_code, total, attempts";
bteq -c ASCII < /home/hdp_oc_team/bteqscripts/ShopperFailedBilling.btq