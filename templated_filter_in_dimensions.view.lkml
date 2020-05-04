view: templated_filter_in_dimensions {
##############################################################################
# THIS IS AN EXAMPLE OF USING A TEMPLATED FILTER IN A DIMENTSION OR A MEASURE #
###############################################################################

    derived_table: {
      sql: SELECT
             order_items.created_at as "created_at",
             users.id as "user_id",
             order_items.order_id as "order_id",
             users.city as "city",
             users.state as "state",
             users.traffic_source as "traffic_source",
             users.age as "user_age",
             coalesce(sum(order_items.sale_price), 0) as "sale_price"
        FROM public.order_items as order_items
        LEFT JOIN public.users as users on order_items.user_id = users.id
        GROUP BY 1,2,3,4,5,6,7 ;;
    }

    # REGULAR FIELDS

    dimension_group: created {
      type: time
      timeframes: [date, week, month, year]
      sql: ${TABLE}.created_at ;;
    }

    dimension:user_id {
      type: number
      hidden: yes
      sql:  ${TABLE}.user_id ;;
    }

    dimension:order_id {
      type: number
      hidden: yes
      sql:  ${TABLE}.order_id ;;
    }
    dimension: users_city {
      type: string
      sql: ${TABLE}.city ;;
    }

    dimension: users_state {
      type: string
      sql: ${TABLE}.state ;;
    }

    dimension: traffic_source {
      type: string
      sql: ${TABLE}.traffic_source ;;
    }

    dimension:  age_bucket {
      type: tier
      sql:${TABLE}.user_age ;;
      tiers: [20, 30, 40, 50, 60, 70]
      style:  integer
    }

    measure: count_users {
      type: count_distinct
      value_format_name: decimal_0
      sql:  ${user_id} ;;
    }

    measure: count_orders {
      type: count_distinct
      value_format_name: decimal_0
      sql:  ${order_id} ;;
    }

    measure: user_average_age {
      type: average
      value_format_name: decimal_0
      sql:  ${TABLE}.user_age ;;
    }

    measure: order_sale_price {
      type: sum
      value_format_name: decimal_0
      sql:  ${TABLE}.sale_price ;;
    }

    # TEMPLATED FILTER IN A DIMENSION

    filter: timeframe {
      suggestions: ["Daily", "Weekly", "Monthly", "Yearly"]
    }

    dimension: variable_timeframe {
      sql: CASE
        WHEN {% condition timeframe %} 'Daily' {% endcondition %} THEN TO_CHAR(${created_date},'YYYY-MM-DD')
        WHEN {% condition timeframe %} 'Weekly' {% endcondition %} THEN ${created_week}
        WHEN {% condition timeframe %} 'Monthly' {% endcondition %} THEN ${created_month}
        WHEN {% condition timeframe %} 'Yearly' {% endcondition %} THEN TO_CHAR(${created_year}, '9999')
      END
       ;;
    }

    # TEMPLATED FILTER IN A MEASURE

    filter: measure_type {
      suggestions: ["User Count", "Order Count", "User Average Age", "Order Total Sale Price"]
    }

    measure: variable_measure {
      type: number
      sql: case
        when {% condition measure_type %} 'User Count' {% endcondition %} then ${count_users}
        when {% condition measure_type %} 'Order Count' {% endcondition %} then ${count_orders}
        when {% condition measure_type %} 'User Average Age' {% endcondition %} then ${user_average_age}
        when {% condition measure_type %} 'Order Total Sale Price' {% endcondition %} then ${order_sale_price}
        end
       ;;
      value_format_name: decimal_0
    }

  }
