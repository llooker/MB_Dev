view: test_concat {
  derived_table: {
    sql: SELECT id, last_name, first_name from public.users ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: last_name {}
  dimension: first_name {}

  dimension: full_name {
    type: string
    sql: CONCAT(${last_name}, ${first_name}) ;;
  }

}
