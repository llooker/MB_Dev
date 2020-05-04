view: pdt_example {
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
  persist_for: "10 minutes"
  indexes: ["user_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: orders_created_date {
    type: date
    sql: ${TABLE}.orders_created_date ;;
  }

  dimension: users_created_date {
    type: number
    sql: ${TABLE}.users_created_date ;;
  }

  dimension: total_gross_revenue_90_days {
    type: number
    sql: ${TABLE}.total_gross_revenue_90_days ;;
  }

  dimension: total_gross_revenue {
    type: number
    sql: ${TABLE}.total_gross_revenue ;;
  }

  dimension: average_gross_revenue {
    type: number
    sql: ${TABLE}.average_gross_revenue ;;
  }

  set: detail {
    fields: [
      order_id,
      user_id,
      orders_created_date,
      users_created_date,
      total_gross_revenue_90_days,
      total_gross_revenue,
      average_gross_revenue
    ]
  }
}
