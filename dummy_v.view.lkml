view: dummy_v {
    derived_table: {
      sql:
         SELECT
            DATE(order_items.created_at ) AS created_date,
            TO_CHAR(DATE_TRUNC('week', order_items.created_at ), 'YYYY-MM-DD') AS created_week,
            to_char( order_items.created_at, 'YYYY-MM') created_month
            FROM public.order_items  AS order_items
            ORDER BY created_date desc;;
    }


    dimension: created_date {
      type: date
      sql:  ${TABLE}.created_date ;;
    }

  dimension: created_month {
    type: string
    sql:  ${TABLE}.created_month ;;
  }

}
