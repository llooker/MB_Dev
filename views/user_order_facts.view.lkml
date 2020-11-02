view: user_order_facts {
  derived_table: {
    sql_trigger_value: select current_date;;
    sql: select
        user_id,
        count(distinct order_items.order_id) order_count
      from public.order_items
      group by user_id

       ;;
      publish_as_db_view: yes
      distribution_style: all
  }

  measure: count {
    type: count
    # drill_fields: [detail*]
  }


  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: order_count {}


}
