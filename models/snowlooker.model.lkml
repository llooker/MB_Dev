connection: "snowlooker"
# include: "/*/*.dashboard"
include: "/*/*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

datagroup: ecommerce_etl {
  sql_trigger: select current_date ;;
  max_cache_age: "1 hour"
}

datagroup: hourly_refresh {
  sql_trigger: select (DATE_TRUNC('hour', current_timestamp)) ;;
  max_cache_age: "1 hour"
}

access_grant: findatausers {
  user_attribute: can_see_pii
  allowed_values: ["Yes"]
}

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
## test comment

# aggregate_awareness: yes

explore: order_items_incremental {}

test: status_is_not_null {
  explore_source: agg_aware {
    column: status {field: order_items.status}
    sort: {
      field: order_items.status
      desc: yes
    }
    limit: 1
  }
  assert: status_is_not_null {
    expression: NOT is_null(${order_items.status}) ;;
  }
}


explore: agg_aware {
  from: order_items
  view_name: order_items
  extends: [order_items]
  label: "Agg Aware Order Items"
  aggregate_table: sale_price_by_day {
    query: {
      dimensions: [order_items.created_date]
      measures: [order_items.total_revenue, order_items.count]
      timezone: America/Los_Angeles
    }
    materialization: {
      datagroup_trigger: ecommerce_etl
    }
  }
  aggregate_table: sale_price_by_week {
    query: {
      dimensions: [order_items.created_week]
      measures: [order_items.total_revenue, order_items.count, order_items.average_sales_price]
      # filters: [order_items.status: "Complete"]
      timezone: America/Los_Angeles
    }
    materialization: {
      datagroup_trigger: ecommerce_etl
    }
  }
  aggregate_table: sale_price_by_status {
    query: {
      dimensions: [order_items.created_date, order_items.status]
      measures: [order_items.total_revenue, order_items.count]
      timezone: America/Los_Angeles
      filters: [order_items.created_date: "last 30 days"]
    }
    materialization: {
      datagroup_trigger: ecommerce_etl
    }
  }
  aggregate_table: sales_price_by_brand {
    query: {
    dimensions: [order_items.created_date, products.brand]
    measures: [order_items.total_revenue, order_items.count, ]
    filters: [order_items.created_date: "last 30 days"]
   }
    materialization: {
      datagroup_trigger: ecommerce_etl
    }
  }
}

# case_sensitive: no

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
    required_access_grants: [findatausers]
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

explore: users {}
