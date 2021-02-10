
# view: synthetic_date_test {
#   derived_table: {
#     sql_trigger_value: SELECT FORMAT(getdate(), 'yyyy-MM-dd HH:mm') as date_time;;
#     increment_key: "created_hour"
#     increment_offset: 1
#     sql: SELECT rand() as random_num,
#       FORMAT(getdate(), 'yyyy-MM-dd HH:mm') as date_time
#     WHERE {% incrementcondition %}  FORMAT(getdate(), 'yyyy-MM-dd HH:mm') {% endincrementcondition %}
#   ;;

#     }
#     dimension_group: date_time {
#       sql: ${TABLE}.date_time ;;
#       timeframes: [raw,date,time]
#     }
#     dimension: random_num {}
#   } add test comment added

view: order_items_incremental {

  derived_table: {
    datagroup_trigger: hourly_refresh
    sql: SELECT
            ID, ORDER_ID, USER_ID, CREATED_AT, SALE_PRICE, STATUS
          FROM "PUBLIC"."ORDER_ITEMS"
          WHERE {% incrementcondition %}  CREATED_AT {% endincrementcondition %}
          AND CREATED_AT > DATE '2021-01-01'
      ;;
    increment_key: "created_hour"
    increment_offset:  1
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: created_hour {
    type:  date
    sql: DATE_PART('hour', ${TABLE}."CREATED_AT") ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [date, time, hour, month, year]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  set: detail {
    fields: [
      id,
      order_id,
      user_id,
      created_at_time,
      sale_price,
      status
    ]
  }
}
