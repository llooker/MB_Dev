view: order_items {
  sql_table_name: public.order_items ;;
  # adding a comment to test advanced deploy

  filter: date_range_filter {
    # define the date range for initial filter. The date range specified here will be used to compare
    # against one or more preceding periods
    type:  date
    convert_tz: no # not required. used here to simplify code
  }

  parameter: period_duration_filter {
    # home many previous periods do you want to compare against.
    type: number
    allowed_value: {
      value: "1"
    }
    allowed_value: {
      value: "2"
    }
    allowed_value: {
      value: "3"
    }
    allowed_value: {
      value: "4"
    }
    default_value: "2"
    # number of periods to compare 2, 3, 5, etc
  }

  parameter: period_comparison_filter {
    # Select the period to comapre against.. If Year is selected, the date ranges will be compared
    # for number of years defined in period_duration_filter. If Months is selected, we will compare against
    # number of preceeding months
    type: string
     allowed_value: {
      value: "Year"
    }
    allowed_value: {
      value: "Month"
    }
    default_value: "Year"
    # type of periods to compare - preceding month, year
  }

  parameter: display_granularity_filter {
    type: string
    allowed_value: {
        value: "Day"
    }
    allowed_value: {
      value: "Week"
    }
    allowed_value: {
      value: "Month"
    }
  }

  dimension_group: date_start_date {
    type: time
    timeframes: [date, month, year]
    sql: COALESCE({% date_start date_range_filter %}, current_date) ;;
  }

  dimension_group: date_end_date {
    type: time
    timeframes: [date, month, year]
    sql: COALESCE({% date_end date_range_filter %}, current_date) ;;
  }

  dimension: first_period_start_date {
    type: date
    sql: DATEADD( {% parameter period_comparison_filter %},
                  {% parameter period_duration_filter %} * -1,
                  ${date_start_date_date} )
        ;;
  }

  dimension: period_display {
    type: string
    label_from_parameter: period_comparison_filter
    sql: CASE WHEN {% parameter period_comparison_filter %} = 'Year' THEN
                 CAST(${created_year} AS VARCHAR)
              WHEN {% parameter period_comparison_filter %} = 'Month' THEN
                  ${created_month}
              END

        ;;
  }

  dimension: granularity_display {
    type: number
    label_from_parameter: display_granularity_filter
    sql:  CASE WHEN {% parameter display_granularity_filter %} = 'Month' THEN
                 ${created_month_num}
              WHEN {% parameter display_granularity_filter %} = 'Week' THEN
                  (${created_week_of_year})
              WHEN {% parameter display_granularity_filter %} = 'Day' THEN
                  (${created_day_of_month})
              END

        ;;
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      week_of_year,
      month,
      month_num,
      day_of_month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    convert_tz: no
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

  measure: total_sales_price {
    type: sum
    sql: ${sale_price} ;;
   value_format_name: usd
  }

  measure: average_sales_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  dimension: display_tip {
    type: string
    sql: "" ;;
    html:
    This is a test;;
  }

  measure: display_more_in_tool_tip{
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    html:
        <summary style="outline:none"> Sales Price: {{ display_more_in_tool_tip.rendered_value }}</summary>
        <summary style="outline:none"> Average Sales Price: {{ average_sales_price._rendered_value }}</summary>
        <summary style="outline:none">  Count of Items: {{ count._rendered_value }}</summary>
        <summary style="outline:none">  Total Sales Price: {{ total_sales_price._rendered_value }}</summary>
        <br/>;;
  }
}
