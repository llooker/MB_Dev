view: user_behavior {
  derived_table: {
    sql: SELECT
          m1.user_id, m1.id, m1.created_at, m2.created_at next_date
        ,DATEDIFF(m2.created_at, m1.created_at) days_between_orders,
          m1.rank
      FROM

      (select o1.user_id, o1.id, o1.created_at, COUNT(*) as rank
             FROM orders o1
             JOIN orders o2
             ON (o2.created_at <= o1.created_at)
             AND (o2.user_id = o1.user_id)
             group by o1.user_id, o1.id, o1.created_at
             order by 1, 2, 3 DESC) m1
      LEFT JOIN
      (select o1.user_id, o1.id, o1.created_at, COUNT(*) as rank
             FROM orders o1
             JOIN orders o2
             ON (o2.created_at <= o1.created_at)
             AND (o2.user_id = o1.user_id)
             group by o1.user_id, o1.id, o1.created_at
             order by 1, 2, 3 DESC) m2
        ON m1.user_id = m2.user_id
        AND m1.rank + 1 = m2.rank
       ;;
  }

  dimension: user_order_id {
    type: number
    sql: CONCAT(${user_id}, ${order_id}, ${order_rank}) ;;
    primary_key: yes
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: next_date {
    type: time
    sql: ${TABLE}.next_date ;;
  }

  dimension: days_between_orders {
    type: number
    sql: ${TABLE}.days_between_orders ;;
  }

  dimension: order_rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: repeat_orders_in_60_days {
    type: yesno
    sql: ${days_between_orders} <= 60 ;;
  }

  measure: average_days_between_orders {
      type: average
      sql: ${days_between_orders}  ;;

  }

  measure: count_of_repeat_order_customers_ {
    type: count
    filters: {
        field: repeat_orders_in_60_days
        value: "yes"
    }
  }

  set: detail {
    fields: [
      user_id,
      order_id,
      created_at_time,
      next_date_time,
      days_between_orders,
      order_rank
    ]
  }
}
