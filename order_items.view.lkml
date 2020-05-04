view: order_items {
  sql_table_name: demo_db.order_items ;;

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
    # hidden: yes
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
    value_format_name: decimal_2
    sql: ${TABLE}.sale_price ;;
  }

  dimension: sale_margin {
    type: number
    description: "Gross revenue for completed orders and non-returned items"
    value_format_name: decimal_2
    sql: CASE
          WHEN  ${orders.status} = 'complete' AND ${returned_date} IS NULL
            THEN  ${sale_price}
          ELSE 0
        END ;;
  }

  dimension:  returned_item {
    type: yesno
    sql: ${returned_date} is NOT NULL ;;
  }

dimension: is_customer_order_in_365_days_from_first_order{
  type: yesno
  sql:  ${orders.created_date} BETWEEN ${users.customer_first_order_date} AND ${users.customer_first_order_date_plus} ;;
}
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_of_returned_items {
    type: count
    filters: {
      field: returned_item
      value: "yes"
    }
  }

  measure: count_category {
    type: number
    sql:
          SUM( CASE WHEN ${products.category} = 'Shorts' THEN 1 ELSE 0 END) ;;
  }

measure: sum_of_orders_in_365{
  type: sum
  filters: {
    field: is_customer_order_in_365_days_from_first_order
    value: "yes"
  }
}
#   measure:  max_order_date {
#     type:  max
#     sql:  ${orders.created_date};;
#
#   }
#
#   measure: return_time_expression {
#     type: string
#     sql:
#     CONCAT(
#    IF(FLOOR(HOUR(TIMEDIFF(${max_order_date}, CURDATE())) / 24) = 0, '', CONCAT(FLOOR(HOUR(TIMEDIFF(${max_order_date}, CURDATE())) / 24), ' days, ')),
#    IF(MOD(HOUR(TIMEDIFF(${max_order_date}, CURDATE())), 24) = 0, '', CONCAT(MOD(HOUR(TIMEDIFF(${max_order_date}, CURDATE())), 24), ' hours, ')),
#    IF(MINUTE(TIMEDIFF(${max_order_date}, CURDATE())) = 0, '', CONCAT(MINUTE(TIMEDIFF(${max_order_date}, CURDATE())), ' minutes, ')),
#    SECOND(TIMEDIFF(${max_order_date}, CURDATE())), ' seconds') ;;
#
#
#     }
#
#     measure: return_time_exp_avg {
#       type: string
#       sql: ${return_time_expression} ;;
#       html:<div> Item Return Rate: {{ return_time_expression._linked_value }}</div>;;
#
#       #<div> Item Return Rate: {{ return_time_exp_avg._rendered_value }}</div>;;
#     }

    measure: item_return_rate {
      type: number
      sql: ${count_of_returned_items}/${count} ;;
#       html:<div> Item Return Rate: {{ return_time_expression._linked_value }}</div>;;
#       label: "Item Return Rate lbl"
    }

    measure: total_sales_price {
      type:  sum
      value_format_name: usd
      sql: ${TABLE}.sale_price ;;
    }

    measure: average_sales_price {
      type: average
      value_format_name: decimal_2
      sql: ${TABLE}.sale_price ;;
    }

    measure:  total_adjusted_revenue {
      description: "total adjusted sales for completed orders and non-returned items"
      value_format_name: usd
      type: sum
      sql: ${sale_price} ;;
      filters: {
        field: orders.status
        value: "complete"
      }
      filters: {
        field: returned_item
        value: "no"
      }
    }

    measure: total_adjusted_margin {
      type: number
      value_format_name: usd
      description: "Adjusted sales minus inventory cost"
      sql: ${total_adjusted_revenue} - ${inventory_items.total_cost} ;;
      drill_fields: [margin_detail*]
      # html:<a href: "https://localhost:9999/dashboards/10?" </a>  {{value}};;

#       label: "Brands Sold"
#       url: "https://localhost:9999/dashboards/10?"
# #       url: "/explore/model/explore_name?fields=view.field_1,view.field_2,&f[view.filter_1]={{ value }}"
#         icon_url: "http://www.looker.com/favicon.ico"
#         ;;

      }

      measure:  average_gross_margin {
        type: average
        value_format_name: usd
        sql: ${sale_margin} - ${inventory_items.cost} ;;

      }

      measure: count_of_customers_with_returned_items {
        type:  count_distinct
        sql: ${users.id} ;;
        filters: {
          field: returned_item
          value: "yes"
        }
      }

      measure:  percentage_of_customers_with_returns {
        type: number
        value_format_name: percent_2
        sql: 100.0 * ${count_of_customers_with_returned_items}/${users.count} ;;
      }

      measure: avg_sale_price {
        type: average
        sql: ${sale_price} ;;
        value_format_name: usd_0
      }

      measure: total_revenue_new_customers {
        description: "Total revenue for new customers 90 days or newer"
        type: sum
        value_format_name: usd
        sql:${sale_price}  ;;
#         filters: {
#           field: users.new_customer
#           value: "Yes"
#         }
        filters: {
          field: orders.status
          value: "complete"
        }
        filters: {
          field: returned_item
          value: "no"
        }

      }
      measure: cumulative_sales_total {
        type: running_total
        label: "Cumulative Sales Total"
        value_format_name: usd
        sql: ${sale_price} ;;
      }

      measure: total_gross_revenue {
        type: sum
        value_format_name: usd
        label: "Total Gross Revenue"
        sql: ${sale_margin}  ;;
        drill_fields: [margin_detail*]
      }

      measure: total_gross_revenue_percentage {
        type: percent_of_total
        sql: 1.0 * ${total_gross_revenue} ;;
      }

      measure: total_gross_margin_percentage {
        type: percent_of_total
        value_format_name: percent_2
        sql: 1.0 * ${total_adjusted_margin} ;;
      }

      measure:  gross_margin_percentage {
        value_format_name: percent_2
        type: number
        sql: 1.0 * ${total_adjusted_margin}/COALESCE(${total_gross_revenue}, 0) ;;
      }

      measure:  average_spend_per_customer {
        value_format_name: usd
        type: number
        sql: 1.0 * ${total_sales_price}/${users.count} ;;
      }

      measure: total_gross_margin {
        type: sum
        value_format_name: decimal_2
        sql: ${sale_margin} ;;
        html: {{ rendered_value }} || {{ total_gross_margin_percentage._rendered_value }} of total
          ;;
      }

      set: detail {
        fields: [id,
          orders.created_at,
          orders.status,
          returned_date,
          products.brand,
          products.item_name,
          sale_price]
      }

      set: margin_detail {
        fields: [products.brand, products.category, products.item_name, order_items.count]
      }
    }
