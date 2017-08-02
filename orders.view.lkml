view: orders {
  sql_table_name: public.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: extracted_created {
    type: time
    timeframes: [ day_of_month, hour_of_day, minute, second]
    sql:   ${TABLE}.created_at;;
  }

#   dimension: date_diff_1 {
#       type: date_time
#       sql: DATEDIFF(${TABLE}.created_at, current_date);;
#   }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

dimension: order_date_diff {
  type: string
  sql:
 CONCAT(
   IF(FLOOR(HOUR(TIMEDIFF(NOW(), ${created_date})) / 24) = 0, '', CONCAT(FLOOR(HOUR(TIMEDIFF(NOW(), ${created_date})) / 24), ' days, ')),
   IF(MOD(HOUR(TIMEDIFF(NOW(), ${created_date})), 24) = 0, '', CONCAT(MOD(HOUR(TIMEDIFF(NOW(), ${created_date})), 24), ' hours, ')),
   IF(MINUTE(TIMEDIFF(NOW(), ${created_date})) = 0, '', CONCAT(MINUTE(TIMEDIFF(NOW(), ${created_date})), ' minutes, ')),
   SECOND(TIMEDIFF(NOW(), ${created_date})), ' seconds')
;;
}

  measure: count {
    type: count
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
  }
}
