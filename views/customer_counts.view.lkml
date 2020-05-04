view: customer_counts {
  filter: orders_after {
      label: "Test Fiter to limit orders created date"
      type: date
      # default_value: "2017-01-01"
      # suggest_dimension: orders.created_date
  }

  label: "Customer Facts"

  derived_table: {
    sql:
    SELECT orders.user_id user_id,
         {% if date_granularity._parameter_value == 'DATE' %} DATE(orders.created_at)
         {% elsif date_granularity._parameter_value == 'MONTH' %} DATE(orders.created_at, '%y-%m')
         {% elsif date_granularity._parameter_value == 'YEAR' %} YEAR(orders.created_at)
          {% endif %} as order_date,
           COUNT(DISTINCT orders.id ) customer_distinct_order_count,
           COUNT(orders.id) customer_total_orders,
           MAX(NULLIF(orders.created_at, 0)) customer_last_order_date,
           MIN(NULLIF(orders.created_at, 0)) customer_first_order_date,
           DATEDIFF(MAX(NULLIF(orders.created_at,0)),MIN(NULLIF(orders.created_at,0))) AS days_as_customer,
           DATEDIFF(CURDATE(),MAX(NULLIF(orders.created_at,0))) AS days_since_last_order
      FROM demo_db.order_items  AS order_items
        LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
        WHERE orders.created_at BETWEEN
        --{% date_start orders_after %} AND {% date_end orders_after %}
       COALESCE( {% date_start orders_after %}, DATE_ADD({% date_end orders_after %}, INTERVAL -30 DAY))
       AND {% date_end orders_after %}
        GROUP BY orders.user_id,
         {% if date_granularity._parameter_value == 'DATE' %} DATE(orders.created_at)
         {% elsif date_granularity._parameter_value == 'MONTH' %} DATE(orders.created_at, '%y-%m')
         {% elsif date_granularity._parameter_value == 'YEAR' %} YEAR(orders.created_at)
          {% endif %}
          ;;
      #indexes: ["user_id"]
      #sql_trigger_value: SELECT CURDATE() ;;
      # persist_for: "24 hours"
    }

parameter: date_granularity {
  type:  unquoted
  allowed_value: {
    value: "DATE"
  }
  allowed_value: {
    value: "MONTH"
  }
  allowed_value: {
    value: "YEAR"
  }
}


  dimension: create_start_date {
    type: string
    hidden: yes
    sql: COALESCE( {% date_start orders_after %}, DATEADD(${create_end_date}, INTERVAL DAY -30) ;;
  }



dimension: created_date {
  type: date
  sql: ${TABLE}.created_date ;;
}

dimension: period {
  type: string
  sql: CASE WHEN ${created_date} BETWEEN  ${create_start_date} AND ${create_end_date} THEN 'Current Period'
      ELSE 'Previous Period'
      END;;
}
  parameter: user_state {
    type: string
  suggest_explore: users
  suggest_dimension: users.state

  }

  dimension: create_end_date {
    type: string
    hidden: yes
    sql: {% date_end orders_after %} ;;
  }
    dimension: user_id {
      type: number
      sql: ${TABLE}.user_id ;;
      primary_key: yes
    }

    dimension: customer_order_count {
        type: number
        # hidden: yes
        sql:  ${TABLE}.customer_distinct_order_count ;;
    }

    dimension: customer_order_count_tier {
      type: tier
      tiers: [1,2,3,6,10]
      style: integer
      sql: ${customer_order_count} ;;
    }

    dimension: customer_last_order_date {
      type: date
      sql: ${TABLE}.customer_last_order_date ;;
    }

    dimension: customer_first_order_date {
      type: date
      sql: ${TABLE}.customer_first_order_date ;;
    }

    dimension: repeat_customer {
      type: yesno
      sql: ${customer_order_count} > 1 ;;
    }

    measure: average_orders_count {
      type: average
      sql: ${customer_order_count} ;;
    }

    dimension: days_since_last_order {
      type: number
      sql:  ${TABLE}.days_since_last_order;;
    }

    dimension: days_since_customer {
        type: number
        sql: ${TABLE}.days_as_customer ;;
    }
    dimension: active_customer {
      type: yesno
      sql: ${days_since_last_order} <= 90 ;;
    }

    measure: average_days_since_last_order {
      type: average
      sql: ${TABLE}.days_since_last_order;;
    }
    measure: total_orders {
      type: sum
      sql:  ${customer_order_count} ;;
    }

    measure: count_of_active_customer{
      type: count
      filters: {
        field: active_customer
        value: "yes"
      }
    }
}
