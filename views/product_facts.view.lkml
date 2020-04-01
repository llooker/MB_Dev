view: product_facts {
  sql_table_name: public.product_facts ;;

  dimension: image_file {
    type: string
    sql: ${TABLE}.image_file ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  measure: count {
    type: count
    drill_fields: [name, products.id, products.item_name]
  }
}
