connection: "thelook_events_redshift"

# include all the views
include: "/*/*.view"
include: "/dummy_v.view"

# include all the dashboards
# include: "*.dashboard"


explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  access_filter: {
    field: users.state
    user_attribute: state
  }
  always_filter: {
    filters: {
        field: order_items.created_date
        value: "7 days ago for 7 days"
      }
    }

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
}

explore: order_items_test {
  from: orders_dynamic
  label: "Orders Dynamic"
  join: users {
    type: left_outer
    sql_on: ${order_items_test.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: product_facts {
  join: products {
    type: left_outer
    sql_on: ${product_facts.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: users {
}


# explore:  orders_users_ext {
#   from: orders
#   view_name: orders
#   view_label: "orders_ext"
#   extends: [orders]
#   hidden: no
#
# #   sql_always_where: ${users.created_date} > "2016-01-01" ;;
#   join: users {
# #       sql_table_name: public.users ;;
#       from: users_ext
#       type: left_outer
#       relationship: many_to_one
#       sql_on: ${users.id} = ${orders.user_id} ;;
#       #fields: [detail_fields*]
#   }
# }
