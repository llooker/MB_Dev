# view: company_list {
#   sql_table_name: public.company_list ;;

#   dimension: company_id {
#     type: string
#     sql: ${TABLE}.company_id ;;
#     description: 'test comment'
#   }

#   measure: count {
#     type: count
#     drill_fields: []
#   }
#   # adding comment
# }
