view: customer_revenue {
  derived_table: {
    sql: SELECT
        --orders.id AS 'order_id',
        users.id AS user_id,
        DATE(orders.created_at ) AS `orders_created_date`,
        --DATE(users.created_at ) AS `users_created_date`,
        COALESCE(SUM(CASE
                WHEN  orders.status = 'complete' AND (DATE(order_items.returned_at )) IS NULL
                AND (((users.created_at ) >= ((DATE_ADD(CURDATE(),INTERVAL -89 day)))
                AND (users.created_at ) < ((DATE_ADD(DATE_ADD(CURDATE(),INTERVAL -89 day),INTERVAL 90 day)))))
                  THEN  order_items.sale_price
                ELSE 0
              END  ), 0) AS `total_gross_revenue_90_days`,
        COALESCE(SUM(CASE
                WHEN  orders.status = 'complete' AND (DATE(order_items.returned_at )) IS NULL
                THEN  order_items.sale_price
                ELSE 0
              END  ), 0) AS `total_gross_revenue`,
        COALESCE(AVG(CASE
                WHEN  orders.status = 'complete' AND (DATE(order_items.returned_at )) IS NULL
                THEN  order_items.sale_price
                ELSE 0
              END  ), 0) AS `average_gross_revenue`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id

      GROUP BY 1,2
      ORDER BY DATE(orders.created_at )
       ;;
      # persist_for: "1 hour"
      # indexes: ["user_id"]
  }

  measure: count_of_customers {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: orders_created_date {
    type: date
    sql: ${TABLE}.orders_created_date ;;
  }

  # dimension: users_created_date {
  #   type: date
  #   sql: ${TABLE}.users_created_date ;;
  # }

  dimension: total_gross_revenue_90_days {
    type: number
    value_format_name: usd
    sql: ${TABLE}.total_gross_revenue_90_days ;;
  }

dimension: total_gross_revenue {
    type: number
    sql: ${TABLE}.total_gross_revenue ;;
}
dimension: customer_revenue_tier {
    type: tier
    style: relational
    tiers: [4.99, 9.99, 49.99, 99.99, 499.99, 999.99]
    sql: ${total_gross_revenue} ;;
}

  set: detail {
    fields: [order_id, orders_created_date, total_gross_revenue_90_days]
  }
}
