view: sfx_test {
 derived_table: {
   create_process: {
      # step 1 - Add new partition
     sql_step: msck repair table looker_test.orders ;;
      # step 2: clean deat names
      sql_step:
          select id as order_id, created_at, user_id, order_amount from looker_test.orders
        ;;
      # step 3: append to deal table

   }
   datagroup_trigger: sfx_refresh
 }

  dimension: order_id {}
  dimension: user_id {}
  dimension: amount {}

}
