connection: "thelook"

## Adding test comments
## Adding test comments 2

## Adding test comments 3
## Adding test comments 4

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


map_layer: my_neighborhood_layer {
  file: "map.topojson"
  property_key: "neighborhood"
}
explore: events {
  label: "Events Label"
  group_label: "Events Group"
conditionally_filter: {}
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.order_id} ;;
    relationship: one_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: customer_revenue {
    type: left_outer
    sql_on: ${customer_revenue.orders_created_date} = ${orders.created_date}
            AND ${customer_revenue.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: customer_counts {
    type: left_outer
    sql_on: ${customer_counts.user_id} = ${orders.user_id} ;;
    relationship: one_to_one
  }

  join:  user_behavior {
      type: left_outer
      sql_on:  ${users.id} = ${user_behavior.user_id} ;;
      relationship: many_to_one
  }

}

explore: customers {

#   sql_always_where: {% parameter create_date_filter %} > ${orders.created_date} ;;
  view_name: order_items
  # sql_always_where: ${customer_counts.customer_first_order_date} > {% parameter date_filter %};;
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: customer_counts {
    type: left_outer
    sql_on: ${customer_counts.user_id} = ${orders.user_id} ;;
    relationship: one_to_one
  }

  join: customer_revenue {
    type: left_outer
    sql_on: ${customer_revenue.order_id} = ${order_items.order_id} ;;
    relationship: many_to_one
  }
  join:  templated_filter_example {
      type: left_outer
      sql_on: ${orders.created_date} = ${templated_filter_example.created_date} ;;
      relationship:one_to_many
  }

}

explore: orders {
  always_join: [users]
  sql_always_where: 1=1
    {% if users.search_field._is_filtered %}
      and {% condition users.search_field  %} users.id {% endcondition %}
    {% endif %};;
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one

  }
  # join: users_dup {
  #   type: left_outer
  #   sql_on: ${users_dup.id} = ${users.id} ;;
  #   relationship: one_to_one
  # }
}

explore: orders1 {
  from: orders
  always_join: [users]
  sql_always_where: 1=1
    {% if users.search_field._is_filtered %}
      and
        users.id = split_part({% parameter users.search_field  %}, "|", 1)
    {% endif %};;
  join: users {
    type: left_outer
    sql_on: ${orders1.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}



explore: products {
  # always_filter: {
  #     filters: {
  #       field: products.product_brand_filter
  #       value: ""
  #     }
  # }
  sql_always_where: {% condition products.brand_filter %} brand {% endcondition %};;
  # sql_always_where: {% condition product_brand_filter %} products.brand  {% endcondition %} ;;
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: users_dup {}

explore: users_nn {}

explore: user_behavior {}

explore: templated_filter_example {
  join: users {
    type: left_outer
    relationship: one_to_one
    sql_on: ${users.city} = ${templated_filter_example.users_city} ;;
  }
  join: orders {
    type: left_outer
    relationship: one_to_one
    sql_on: ${orders.created_date} = ${templated_filter_example.created_date} ;;
  }
}

explore: pdt_example {}

explore: products_ROJ {
  from: products
  join: inventory_items {
    relationship: one_to_many
    sql: RIGHT JOIN inventory_items ON ${products_ROJ.id} = ${inventory_items.product_id};;
  }
  join: customer_counts {
    relationship: one_to_many
    sql:  RIGHT JOIN customer_counts ON ${customer_counts.user_id} = ${products_ROJ.id} ;;
  }
}
