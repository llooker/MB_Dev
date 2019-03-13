view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
#     hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
   # drill_fields: [id, orders.id, products.item_name, sale_price, inventory_items.cost]
  }

 measure: orders_count {
   type: count_distinct
    sql: ${order_id} ;;
 }

measure: gross_amount {
    type: sum
    sql: ${sale_price} ;;
}

dimension: sales_margin {
    type: number
    sql: ${sale_price} - ${inventory_items.cost} ;;
    value_format: "0.00"
}

# example of referenced field
#   dimension:  sales_margin {
#     type: number
#      sql: ${sale_price} - ${inventory_items.cost} ;;
#   }

# example of yesno field
#   dimension: returned_item  {
#     type: yesno
#     sql: ${returned_date} IS NOT NULL ;;
#   }

# example showing using yes no field
#   measure: count_of_returned_items {
#     type: count
#     filters: {
#       field: returned_item
#       value: "yes"
#     }
#   }

  dimension: adjusted_revenue {
    description: "Revenue for completed orders and non-returned items"
    type: number
    value_format_name: decimal_2
    sql: CASE
        WHEN  ${orders.status} = 'complete' AND ${returned_date} IS NULL THEN  ${sale_price}
        ELSE 0
  END ;;
  }
#
  measure: total_adjusted_revenue {
    type: sum
    value_format_name: usd
    sql: ${adjusted_revenue} ;;
  }
#
  measure:  total_inventory_cost {
    type:  sum
    value_format_name: decimal_2
    sql: ${inventory_items.cost} ;;
  }
#
  measure: total_adjusted_margin {
    type: number
    value_format_name: usd
    description: "Adjusted sales minus inventory cost"
    sql: ${total_adjusted_revenue} - ${total_inventory_cost} ;;
    drill_fields: [margin_detail*]
  }
#
  set: margin_detail {
    fields: [products.brand, products.category, products.item_name, order_items.count]

  }
}
