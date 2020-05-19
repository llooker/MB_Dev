view: distribution_centers {
  sql_table_name: public.distribution_centers ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: dist_locations {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
    html: {{ name._rendered_value }} ;;
    map_layer_name: us_states
  }

  measure: count {
    type: count
    drill_fields: [id, name, products.count]
  }
}
