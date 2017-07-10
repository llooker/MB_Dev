include: "users.view.lkml"

view: users_ext {
  extends: [users]

  view_label: "Users"
#   sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: full_name {
    type: string
    sql: CONCAT(${TABLE}.first_name}, " ", ${TABLE}.last_name}} ;;
  }

  set: detail_fields {
   fields: [id, age, created_date, full_name, count, city, state, traffic_source   ]
  }
}
