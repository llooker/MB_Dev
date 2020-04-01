connection: "thelook_events_redshift"

# include all the views
include: "/*/*.view"

datagroup: mannyb_sandbox_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM order_items;;
  max_cache_age: "1 hour"
}

persist_with: mannyb_sandbox_default_datagroup

case_sensitive: no

explore: company_list {}

explore: distribution_centers {}

explore: events {
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

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
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
  always_join: [user_order_facts]
  join: user_order_facts {
    type: inner
    relationship: one_to_one
    sql: ${users.id} = ${user_order_facts.user_id} ;;
  }
}
