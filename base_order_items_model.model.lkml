connection: "thelook_events_redshift"

include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project


explore: base_order_items_model {
  view_name: base_order_items # base_outreaches
#   from: base_order_items
#   join: base_mailings
  join: base_orders {
    from: base_orders # actual view name
    relationship: many_to_one
    sql_on: ${base_orders.id} = ${base_order_items.order_id} ;;
  }

}
