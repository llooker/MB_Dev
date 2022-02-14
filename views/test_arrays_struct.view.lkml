view: test_materialized_view {
  derived_table: {
    sql:
        select ['red', 'yellow', 'blue'] as colors
    ;;
    materialized_view: yes
  }

  dimension: colors {
    sql: ${TABLE} ;;
  }
 }
