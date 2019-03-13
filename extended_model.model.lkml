# connection: "thelook_events_redshift"

include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

include: "base_order_items_model.model.lkml" # include base model

explore:  extended_model {  # co_outreaches, ny_outreaches, sc-outreaches
    extends: [base_order_items_model] # extends base_outreaches
     view_name: base_order_items  # base_outreaches view
     sql_table_name: order_items_1 ;;
    fields: [base_order_items.id, base_order_items.order_id, base_order_items.count]

    join: base_orders { # base_mailings
      # we keep all the joins defined in base explore by overwrite the sql_table_name to an
      # actual data table - co.mailings, ny.mailings
        sql_table_name: order_1;;
    }
}
