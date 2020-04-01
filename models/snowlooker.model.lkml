connection: "snowlooker"

include: "/*/*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

aggregate_awareness: yes

case_sensitive: no

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

}

explore: order_items {
  label: "SF Orders"

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    from: users
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
  query: top_5_sales_by_state {
    dimensions: [users.state]
    measures: [total_revenue]
    limit: 5
    sort: {field:total_revenue desc: yes      }
  }
  query: total_users_by_state {
    dimensions: [users.state]
    measures: [user_count]
    limit: 5
    sort: {field: user_count desc:yes}
  }

  query: orders_by_date {
    dimensions: [created_date]
    measures: [count]
    sort: {field: created_date}
    filters: {field:created_date value:"last 7 days"}
  }

}
