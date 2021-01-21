include: "/views/order_items.view"
view: orders_dynamic {
  extends: [order_items]
  sql_table_name:
    {% if users.state._is_filtered %}
      ${order_items.SQL_TABLE_NAME}
    {% else %}
     ${order_items_1.SQL_TABLE_NAME}
    {% endif %}
  ;;

}
