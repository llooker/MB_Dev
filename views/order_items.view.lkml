view: order_items {
  sql_table_name: public.order_items ;;

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
    datatype: timestamp
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
                 ${created_week_of_year}
              WHEN {% parameter display_granularity_filter %} = 'Day' THEN
                 ${created_day_of_month}
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
      month_name,
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
    can_filter: no
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count_distinct
    sql: ${id} ;;
    drill_fields:  [created_time, total_revenue]
  }


measure: total_revenue {
  type:  sum
  sql: ${TABLE}.sale_price ;;
  value_format_name: usd
}

measure: user_count {
  type: count_distinct
  sql: ${users.id} ;;
}

measure: average_revenue_per_user {
  type: number
  sql: ${total_revenue}/nullif(${user_count} ;;

}

  measure: max_created_date_2 {
    type: date
    # sql: (max(date(${TABLE}.created_at))) ;;
    sql: max(${created_date}) ;;
  }

measure: max_created_datetime {
  type: string
  sql: (max(${TABLE}.created_at)) ;;

}

  measure: min_created_datetime {
    type: string
    sql: (min(${TABLE}.created_at)) ;;

  }

  measure: max_created_date {
    type: date
    sql: max(${created_date}) ;;
  }

  measure: count_showing_scatter{
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [created_date, total_revenue]
    link: {
      label: "Show as scatter plot"
      url: "
      {% assign vis_config = '{
      \"stacking\"                  : \"\",
      \"show_value_labels\"         : false,
      \"label_density\"             : 25,
      \"legend_position\"           : \"center\",
      \"x_axis_gridlines\"          : true,
      \"y_axis_gridlines\"          : true,
      \"show_view_names\"           : false,
      \"limit_displayed_rows\"      : false,
      \"y_axis_combined\"           : true,
      \"show_y_axis_labels\"        : true,
      \"show_y_axis_ticks\"         : true,
      \"y_axis_tick_density\"       : \"default\",
      \"y_axis_tick_density_custom\": 5,
      \"show_x_axis_label\"         : false,
      \"show_x_axis_ticks\"         : true,
      \"x_axis_scale\"              : \"auto\",
      \"y_axis_scale_mode\"         : \"linear\",
      \"show_null_points\"          : true,
      \"point_style\"               : \"circle\",
      \"ordering\"                  : \"none\",
      \"show_null_labels\"          : false,
      \"show_totals_labels\"        : false,
      \"show_silhouette\"           : false,
      \"totals_color\"              : \"#808080\",
      \"type\"                      : \"looker_scatter\",
      \"interpolation\"             : \"linear\",
      \"series_types\"              : {},
      \"colors\": [
      \"palette: Santa Cruz\"
      ],
      \"series_colors\"             : {},
      \"x_axis_datetime_tick_count\": null,
      \"trend_lines\": [
      {
      \"color\"             : \"#000000\",
      \"label_position\"    : \"left\",
      \"period\"            : 30,
      \"regression_type\"   : \"average\",
      \"series_index\"      : 1,
      \"show_label\"        : true,
      \"label_type\"        : \"string\",
      \"label\"             : \"30 day moving average\"
      }
      ]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: total_revenue_stacked_drill {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    drill_fields: [total_revenue, created_month_name, created_year]
    link: {
      label: "Show as stacked line"
      url: "
      {% assign vis_config = '{
      \"stacking\"              : \"normal\",
      \"legend_position\"       : \"right\",
      \"x_axis_gridlines\"      : false,
      \"y_axis_gridlines\"      : true,
      \"show_view_names\"       : false,
      \"y_axis_combined\"       : true,
      \"show_y_axis_labels\"    : true,
      \"show_y_axis_ticks\"     : true,
      \"y_axis_tick_density\"   : \"default\",
      \"show_x_axis_label\"     : true,
      \"show_x_axis_ticks\"     : true,
      \"show_null_points\"      : false,
      \"interpolation\"         : \"monotone\",
      \"type\"                  : \"looker_line\",
      \"colors\": [
      \"#5245ed\",
      \"#ff8f95\",
      \"#1ea8df\",
      \"#353b49\",
      \"#49cec1\",
      \"#b3a0dd\"
      ],
      \"x_axis_label\"          : \"Month Number\"
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&sorts=order_items.created_year+asc,order_items.created_month_name+asc&pivots=order_items.created_year&toggle=dat,pik,vis&limit=500&column_limit=15"
    } # NOTE the &pivots=
  }

}
