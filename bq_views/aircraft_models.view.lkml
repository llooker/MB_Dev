view: aircraft_models {
  sql_table_name: `lookerdata.faa.aircraft_models`
    ;;

  dimension: aircraft_category_id {
    type: number
    sql: ${TABLE}.aircraft_category_id ;;
  }

  dimension: aircraft_engine_type_id {
    type: number
    sql: ${TABLE}.aircraft_engine_type_id ;;
  }

  dimension: aircraft_model_code {
    type: string
    sql: ${TABLE}.aircraft_model_code ;;
  }

  dimension: aircraft_type_id {
    type: number
    sql: ${TABLE}.aircraft_type_id ;;
  }

  dimension: amateur {
    type: number
    sql: ${TABLE}.amateur ;;
  }

  dimension: engines {
    type: number
    sql: ${TABLE}.engines ;;
  }

  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }

  dimension: seats {
    type: number
    sql: ${TABLE}.seats ;;
  }

  dimension: speed {
    type: number
    sql: ${TABLE}.speed ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
