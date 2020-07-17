view: manny_test {
  sql_table_name: looker_test_scratch.manny_test ;;
  suggestions: no

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
