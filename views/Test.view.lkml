

# #explore(pop_explore) is defined below the pop views

# view: pop_order_items_created {
#   view_label: "Order Items (By created)"
#   #These are FYI - Currently, Looker does not substitute in sql_table_name, so you must do these by hand
#   dimension: SQL_TABLE_NAME { sql: order_items;; hidden:yes}
#   dimension: date_field {sql: order_items.created_at ;; hidden:yes}
#   dimension: join_date { sql: DATE_TRUNC({% parameter pop.within_period_type %},${date_field}) ;; hidden:yes }
#   # Do these substitutions by hand
#   # sql_table_name: (SELECT
#   #     ${join_date} as join_date
#   #     ${agg_1_inner} as agg_1
#   #   FROM ${SQL_TABLE_NAME}
#   #   GROUP BY ${join_date}
#   # ) ;;
#   sql_table_name: (SELECT
#         DATE_TRUNC({% parameter pop.within_period_type %},order_items.created_at) as join_date,
#         COUNT(*) as agg_1,
#         SUM(order_items.sale_price) as agg_2
#         FROM order_items
#         WHERE {%condition pop_order_items_created.sale_price %}order_items.sale_price{% endcondition %}
#         GROUP BY 1
#         ) ;;
#       #OPTIONAL : Filter inner query on minx/max dates (since query optimizer probably won't)

#   #You can put aggregates and filters directly in the view file
#   #Or, you can extend them from another view like this exampme, so you can join the same view on different
#   # date fields
#     extends: [pop_order_items_base]
#   }
#   view: pop_order_items_delivered {
#     view_label: "Order Items (By delivered)"
#     #These are FYI - Currently, Looker does not substitute in sql_table_name, so you must do these by hand
#     dimension: SQL_TABLE_NAME { sql: order_items;; hidden:yes}
#     dimension: date_field {sql: order_items.shipped_at ;; hidden:yes}
#     dimension: join_date { sql: DATE_TRUNC({% parameter pop.within_period_type %},${date_field}) ;; hidden:yes }
#     # Do these substitutions by hand
#     # sql_table_name: (SELECT
#     #     ${join_date} as join_date
#     #     ${agg_1_inner} as agg_1
#     #   FROM ${SQL_TABLE_NAME}
#     #   GROUP BY ${join_date}
#     # ) ;;
#     sql_table_name: (SELECT
#         DATE_TRUNC({% parameter pop.within_period_type %},order_items.shipped_at) as join_date,
#         COUNT(*) as agg_1,
#         SUM(order_items.sale_price) as agg_2
#         FROM order_items
#         WHERE {%condition pop_order_items_delivered.sale_price %}order_items.sale_price{% endcondition %}
#         GROUP BY 1
#         ) ;;
#       #OPTIONAL : Filter inner query on minx/max dates (since query optimizer probably won't)

#   #You can put aggregates and filters directly in the view file
#   #Or, you can extend them from another view like this exampme, so you can join the same view on different
#   # date fields
#       extends: [pop_order_items_base]
#     }


#     view: pop_order_items_base {
#       extension: required
#       filter: sale_price {
#         type: number
#       }
#       # Do this substitutions by hand in sql_table_name
#       # measure:  agg_1_inner {
#       #   hidden: yes
#       #   sql: COUNT(*) ;;
#       # }
#       measure:  agg_1 {
#         type:  number
#         label: "Count"
#         sql: SUM(${TABLE}.agg_1) ;;
#       }

#       # Do this substitutions by hand in sql_table_name
#       #measure:  agg_2_inner {
#       #  hidden: yes
#       #  sql: SUM(${SQL_TABLE_NAME}.sale_price) ;;
#       #}
#       measure:  agg_2 {
#         type:  number
#         label: "Total Amount"
#         sql: SUM(${TABLE}.agg_2) ;;
#       }
#     }

#     explore: pop_explore {
#       from:  pop
#       view_name: pop
#       join: within_periods { #No editing needed
#         from: numbers
#         type: left_outer
#         relationship: one_to_many
#         fields: []
#         sql_on: ${within_periods.n}
#             <= DATEDIFF( {% parameter pop.within_period_type %},{% date_start pop.date_filter %},{% date_end pop.date_filter %} )
#               * CASE WHEN {%parameter pop.within_period_type %} = 'hour' THEN 24 ELSE 1 END;;
#       }
#       join: over_periods { #No editing needed
#         from: numbers
#         view_label: "[PoP]"
#         type: left_outer
#         relationship: one_to_many
#         sql_on:
#         CASE WHEN {% condition pop.over_how_many_past_periods %} NULL {% endcondition %}
#         THEN
#           ${over_periods.n} <= 1
#         ELSE
#           {% condition pop.over_how_many_past_periods %} ${over_periods.n} {% endcondition %}
#         END;;
#       }
#       #Rename (& optionally repeat) below join to match your pop view(s)
#       join: pop_order_items_created {
#         type: left_outer
#         relationship: many_to_one
#         #Apply join name below in sql_on
#         sql_on: pop_order_items_created.join_date = DATE_TRUNC({% parameter pop.within_period_type %},
#           DATEADD({% parameter pop.over_period_type %}, 0 - ${over_periods.n},
#               DATEADD({% parameter pop.within_period_type %}, 0 - ${within_periods.n},
#                   {% date_end pop.date_filter %}
#               )
#           )
#       );;
#       }
#       join: pop_order_items_delivered {
#         type: left_outer
#         relationship: many_to_one
#         #Apply join name below in sql_on
#         sql_on: pop_order_items_delivered.join_date = DATE_TRUNC({% parameter pop.within_period_type %},
#           DATEADD({% parameter pop.over_period_type %}, 0 - ${over_periods.n},
#               DATEADD({% parameter pop.within_period_type %}, 0 - ${within_periods.n},
#                   {% date_end pop.date_filter %}
#               )
#           )
#       );;
#       }
#       #No editing needed below
#       always_join: [pop,within_periods,over_periods]
#       always_filter: {
#         filters: {
#           field: pop.date_filter
#           value: "last 12 weeks"
#         }
#         filters: {
#           field: pop.within_period_type
#           value: "week"
#         }
#         filters: {
#           field: pop.over_period_type
#           value: "year"
#         }
#       }
#     }




#     # The below views should not need editing (unless you want to add more than 52 periods)
#     view: numbers {
#       sql_table_name: (
#         SELECT 00 as n UNION ALL SELECT 01 UNION ALL SELECT 02 UNION ALL
#         SELECT 03 UNION ALL SELECT 04 UNION ALL SELECT 05 UNION ALL
#         SELECT 06 UNION ALL SELECT 07 UNION ALL SELECT 08 UNION ALL
#         SELECT 09 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL
#         SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL
#         SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL
#         SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL
#         SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL
#         SELECT 24 UNION ALL SELECT 25 UNION ALL SELECT 26 UNION ALL
#         SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL
#         SELECT 30 UNION ALL SELECT 31 UNION ALL SELECT 32 UNION ALL
#         SELECT 33 UNION ALL SELECT 34 UNION ALL SELECT 35 UNION ALL
#         SELECT 36 UNION ALL SELECT 37 UNION ALL SELECT 38 UNION ALL
#         SELECT 39 UNION ALL SELECT 40 UNION ALL SELECT 41 UNION ALL
#         SELECT 42 UNION ALL SELECT 43 UNION ALL SELECT 44 UNION ALL
#         SELECT 45 UNION ALL SELECT 46 UNION ALL SELECT 47 UNION ALL
#         SELECT 48 UNION ALL SELECT 49 UNION ALL SELECT 50 UNION ALL
#         SELECT 51 UNION ALL SELECT 52 )
#       ;;
#       dimension: n {
#         type: number
#         hidden:  yes
#         sql: ${TABLE}.n ;;
#       }
#     }
#     view: pop {
#       sql_table_name: (SELECT NULL) ;;
#       view_label: "[PoP]"
#       dimension: reference_date_formatted {
#         type: string
#         order_by_field: reference_date
#         label: "Reference date"
#         sql:  TO_CHAR(
#             ${reference_date},
#             CASE {% parameter pop.within_period_type %}
#             WHEN 'year' THEN 'YYYY'
#             WHEN 'month' THEN 'MON YY'
#             WHEN 'quarter' THEN 'YYYY"Q"Q'
#             WHEN 'week' THEN 'MM/DD/YY' --or 'YYYY"W"WW' or 'YY-MM"W"W'
#             WHEN 'day' THEN 'MM/DD/YY'
#             WHEN 'hour' THEN 'MM/DD HHam'
#             ELSE 'MM/DD/YY'
#             END)
#           ;;}
#       dimension: reference_date {
#         hidden: yes
#         #type: date_time <-- too aggressive with choosing your string formatting for you
#         #type: date <-- too aggressive with truncating the time part
#         #convert_tz: no
#         #type: nothing <-- just right
#         sql: DATE_TRUNC({% parameter pop.within_period_type %},DATE_ADD({% parameter pop.within_period_type %},0 - ${within_periods.n},{% date_end pop.date_filter %}));;
#       }
#       filter: date_filter  {
#         label: "1. Date Range"
#         hidden: yes
#         type: date
#         convert_tz: no
#       }
#       dimension: over_period_type {
#         label: "3. Compare over"
#         hidden: yes
#         type: string
#         #Using case just to get friendlier UI experience in filters. Otherwise, could have a no-sql filter field
#         case: {
#           when: {
#             sql: {% parameter pop.over_period_type %}='year' ;;
#             label: "year"
#           }
#           when: {
#             sql: {% parameter pop.over_period_type %}='quarter' ;;
#             label: "quarter"
#           }
#           when: {
#             sql: {% parameter pop.over_period_type %}='month' ;;
#             label: "month"
#           }
#           when: {
#             sql: {% parameter pop.over_period_type %}='week' ;;
#             label: "week"
#           }
#           when: {
#             sql: {% parameter pop.over_period_type %}='day' ;;
#             label: "day"
#           }
#         }

#       }
#       dimension: within_period_type {
#         label: "2. Break down date range by"
#         hidden: yes
#         type: string
#         #Using case just to get friendlier UI experience in filters. Otherwise, could have a no-sql filter field
#         case: {
#           when: {
#             sql: {% parameter pop.within_period_type %}='quarter' ;;
#             label: "quarter"
#           }
#           when: {
#             sql: {% parameter pop.within_period_type %}='month' ;;
#             label: "month"
#           }
#           when: {
#             sql: {% parameter pop.within_period_type %}='week' ;;
#             label: "week"
#           }
#           when: {
#             sql: {% parameter pop.within_period_type %}='day' ;;
#             label: "day"
#           }
#           when: {
#             sql: {% parameter pop.within_period_type %}='hour' ;;
#             label: "hour"
#           }
#         }
#       }
#       filter: over_how_many_past_periods {
#         label: "Override past periods"
#         description: "Apply this filter to change which past periods to compare to (from the default of current vs 1 period ago)"
#         type: number
#         default_value: "<=1"
#       }
#       dimension: over_periods_ago  {
#         label: "Prior Periods"
#         description: "Pivot me!"
#         sql: CASE ${over_periods.n}
#           WHEN 0 THEN 'Current '||{% parameter pop.over_period_type %}
#           WHEN 1 THEN ${over_periods.n}||' '||{% parameter pop.over_period_type %} || ' prior'
#           ELSE        ${over_periods.n}||' '||{% parameter pop.over_period_type %} || 's prior'
#           END;;
#         order_by_field: over_periods.n
#       }
#     }
