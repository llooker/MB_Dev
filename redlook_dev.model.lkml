connection: "dev_redshift"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  always_filter: {
    filters: {
        field: orders.created_date
        value: "2017-01-01"
      }
    }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
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

explore: users {}


explore:  orders_users_ext {
  from: orders
  view_name: orders
  view_label: "orders_ext"
  extends: [orders]
  hidden: no

#   sql_always_where: ${users.created_date} > "2016-01-01" ;;
  join: users_ext {
#       sql_table_name: public.users ;;
      type: left_outer
      relationship: many_to_one
      sql_on: ${users_ext.id} = ${orders.user_id} ;;
      fields: [users_ext.full_name, users_ext.count]
  }
}
