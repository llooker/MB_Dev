connection: "snowlooker"

# include all the views
include: "/*/*.view"
include: "/*/*.dashboard"
# include: "/*.strings.json"

datagroup: mannyb_sandbox_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM order_items;;
  max_cache_age: "1 hour"
}

persist_with: mannyb_sandbox_default_datagroup

case_sensitive: no

# ****

# Place in `mannyb_sandbox` model
explore: +order_items {

  query: Top_10_Product_Brands{
    dimensions: [products.brand, order_items.created_date]
    measures: [count, total_revenue]
    filters: [order_items.created_date: "7 days"]
    # timezone: America/New_York

#   aggregate_table: rollup__products_brand__0 {
#     query: Top_10_Product_Brands{
#     dimensions: [products.brand, order_items.created_date]
#     measures: [count, total_revenue]
#     filters: [order_items.created_date: "7 days"]
#     timezone: America/New_York
#   }

#     # query: {
#     #   dimensions: [products.brand, users.state, order_items.created_date]
#     #   measures: [ total_revenue]
#     #   # filters: [order_items.created_date: "7 days", users.state: "New York"]
#     #   timezone: "America/New_York"
#     #   sorts: [created_date: asc]
#     # }

#     materialization: {
#       datagroup_trigger: mannyb_sandbox_default_datagroup
#     }

# }
#   aggregate_table: rollup__created_time__1 {
#     query: {
#       dimensions: [order_items.created_time, users.state, products.brand]
#       measures: [ order_items.total_revenue]
#       filters: [order_items.created_date: "7 days",
#                 users.state: "New York"]
#       timezone: "America/New_York"
#     }

#     materialization: {
#       datagroup_trigger: mannyb_sandbox_default_datagroup

  }
}


#******





explore: distribution_centers {}

explore: events {
  description: "this is sample description to ensure that i an see this in data ditionary app"
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  access_filter: {
    field: products.brand
    user_attribute: brand
  }

  # sql_always_where:
  #   {% _user_attributes["brand"] == 'ABC' %}
  #   1 =1
  #   {% else%}
  #   ${products.brand} = _user_attributes["brand"]
  #   { endif %%}
  # ;;

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {

# sql_always_where: ${products.brand} = '{{_user_attributes["brand"] }}';;
  # sql_always_where:
  #     ${created_date} BETWEEN ${first_period_start_date} AND ${date_end_date_date}
  #     AND EXTRACT('month' from created_at)
  #           IN ( SELECT DISTINCT EXTRACT('month' from created_at)
  #                 FROM public.order_items
  #                 WHERE created_at BETWEEN
  #                     {% if order_items.period_comparison_filter._parameter_value == "'Year'" %}
  #                     ${date_start_date_date} AND ${date_end_date_date}
  #                     {% elsif order_items.period_comparison_filter._parameter_value == "'Month'" %}
  #                     ${first_period_start_date} AND ${date_end_date_date}
  #                     {% endif %}
  #                     )
  #     AND EXTRACT('day' from created_at)
  #           IN ( SELECT DISTINCT EXTRACT('day' from created_at)
  #                 FROM public.order_items
  #                 WHERE created_at BETWEEN ${date_start_date_date} AND ${date_end_date_date})

  # ;;
#      AND ${created_month} BETWEEN ${date_start_date_month} AND ${date_end_date_month}


  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  query: top_5_sales_by_state {
    dimensions: [users.state]
    measures: [total_revenue]
    limit: 5
    sort: {field:total_revenue desc: yes      }
  }
  # query: total_users_by_state {
  #   dimensions: [users.state]
  #   measures: [user_count]
  #   limit: 5
  #   sort: {field: user_count desc:yes}
  # }
}

explore: products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: user_order_facts {}

explore: users {
  # always_join: [user_order_facts]
  join: user_order_facts {
    type: inner
    relationship: one_to_one
    sql: ${users.id} = ${user_order_facts.user_id} ;;
  }
}
