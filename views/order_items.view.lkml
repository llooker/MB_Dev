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
      year,
      hour,
      millisecond
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

  dimension: created_month_str {
    type: string
    sql: to_char(${created_date}, 'YYYY-MM') ;;
    order_by_field: id
    # suggest_explore: dummy_v
    # suggest_dimension: dummy_v.created_month
    # alpha_sort: yes
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
    label: "status.label"
    description: "status.description"
  }

  dimension: status_oig_demo {
    can_filter: no
    type: string
#     sql: ${TABLE}.status ;;
    sql: case
            when ${status} = 'Complete' then 'A'
            when ${status} = 'Pending' then 'E'
            when ${status} = 'Returned' then 'E'
            when ${status} = 'Processing' then 'S'
        ;;
    html:
      <div >
      <table>
      <tr>
      <td style='min-width:; font-size:12px;'>
      {% if {{value}} == "A" %}
      <div class="fa-stack " style="font-size:12px;">
      <i class="fa fa-square fa-stack-2x" style="color:#0071bc"></i>
      <i class="fa fa-stack-1x" style="color:white;">
      <span style="font-family: Open Sans;"><b>A</b></span></i>
      </div>
      <span style="color:#0071bc;"> <b>Possible Alternative Auditee</b></span>
      <div style='font-size:11px;padding-left:28px; padding-right:;'>
      Grantee is linked to another grantee's A-133.
      </div>
      {% endif %}

      {% if {{value}} == "E" %}
      <div class="fa-stack " style="font-size:12px;">
      <i class="fa fa-square fa-stack-2x" style="color:#162e4c"></i>
      <i class="fa fa-stack-1x" style="color:white;">
      <span style="font-family: Open Sans;"><b>E</b></span></i>
      </div>
      <span style="color:#162e4c;"> <b>Exclusion</b></span>
      <div style='font-size:11px;padding-left:28px; padding-right:;'>
      Grantee is associated with an exclusion decision made by any federal agency.
      </div>
      </details>
      {% endif %}

      {% if {{value}} == "D" %}
      <div class="fa-stack " style="font-size:12px;">
      <i class="fa fa-square fa-stack-2x" style="color:#00aa76"></i>
      <i class="fa fa-stack-1x" style="color:white;">
      <span style="font-family: Open Sans;"><b>D</b></span></i>
      </div>
      <span style="color:#00aa76;"> <b>Federal Debt</b></span>
      <div style='font-size:11px;padding-left:28px; padding-right:;'>
      Grantee has outstanding federal debt.
      </div>
      </details>
      {% endif %}

      {% if {{value}} == "S" %}
      <div class="fa-stack " style="font-size:12px;">
      <i class="fa fa-square fa-stack-2x" style="color:#c00000"></i>
      <i class="fa fa-stack-1x" style="color:white;">
      <span style="font-family: Open Sans;"><b>S</b></span></i>
      </div>
      <span style="color:#c00000;"> <b>SBIR/STTR Award</b></span>
      <div style='font-size:11px;padding-left:28px; padding-right:;'>
      Grantee has grant(s) that received an award from the SBIR or STTR program.
      </div>
      {% endif %}

      {% if {{value}} == "O" %}
      <div class="fa-stack " style="font-size:12px;">
      <i class="fa fa-square fa-stack-2x" style="color:#eb6530"></i>
      <i class="fa fa-stack-1x" style="color:white;">
      <span style="font-family: Open Sans;"><b>O</b></span></i>
      </div>
      <span style="color:#eb6530;"> <b>Other OPDIV</b></span>
      <div style='font-size:11px;padding-left:28px; padding-right:;'>
      Grantee has grant(s) administered by an OPDIV that doesn't map to the grant's CFDA number.
      </div>
      {% endif %}

      {% if {{value}} == "C" %}
      <div class="fa-stack " style="font-size:12px;">
      <i class="fa fa-square fa-stack-2x" style="color:#eda11e"></i>
      <i class="fa fa-stack-1x" style="color:white;">
      <span style="font-family: Open Sans;"><b>C</b></span></i>
      </div>
      <span style="color:#eda11e;"> <b>Contact Information Issues</b></span>
      <div style='font-size:11px;padding-left:28px; padding-right:;'>
      Grantee is associated with email address(es) from non-organizational domains.
      </div>
      {% endif %}

      {% if {{value}} == "F" %}
      <div class="fa-stack " style="font-size:12px;">
      <i class="fa fa-square fa-stack-2x" style="color:#5f408b"></i>
      <i class="fa fa-stack-1x" style="color:white;">
      <span style="font-family: Open Sans;"><b>F</b></span></i>
      </div>
      <span style="color:#5f408b;"> <b>Possible Fraud</b></span>
      <div style='font-size:11px;padding-left:28px; padding-right:;'>
      Grantee self-reported they were aware of a significant diversion of assets.
      </div>
      {% endif %}

      {% if {{value}} == "R" %}
      <div class="fa-stack " style="font-size:12px;">
      <i class="fa fa-square fa-stack-2x" style="color:#02bfe7"></i>
      <i class="fa fa-stack-1x" style="color:white;">
      <span style="font-family: Open Sans;"><b>R</b></span></i>
      </div>
      <span style="color:#02bfe7;"> <b>Missing Required Audit</b></span>
      <div style='font-size:11px;padding-left:28px; padding-right:;'>
      Grantee self-reported that a federal audit
      was required but did not report one being performed.
      </div>
      {% endif %}
      </td>
      </tr>
      </table>
      </div>
      ;;

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

    measure: count_with_flag {
      type: count_distinct
      sql: ${id} ;;
      drill_fields:  [created_time, total_revenue]
      html:
          {% if value <= 50 %}
          <span class="fa-stack fa-lg">
                <i class="fa fa-square fa-stack-2x" style="color:#0071bc"></i>
                <span class="fa-stack-1x fa-inverse" style="font-weight:600;">A</span>
              </span>
          {% endif %}
          {% if value > 50 and value < 100 %}
           <span class="fa-stack fa-lg">
                <i class="fa fa-square fa-stack-2x" style="color:#162e4c"></i>
                <span class="fa-stack-1x fa-inverse" style="font-weight:600;">E</span>
              </span>
          {% endif %}
          {% if value > 100 and value <= 500 %}
         <span style="verical-align:top;cursor:help; font-size:9px;padding-top:5px;" title="Federal Debt:
              Grantee has outstanding federal debt [SAM]">
              <span class="fa-stack fa-lg">
                <i class="fa fa-square fa-stack-2x" style="color:#00aa76"></i>
                <span class="fa-stack-1x fa-inverse" style="font-weight:600;">D</span>
              </span>
            </span>
          {% endif %}
          {% if value > 500 %}
           <span class="fa-stack fa-lg">
                  <i class="fa fa-square fa-stack-2x" style="color:#eb6530"></i>
                  <span class="fa-stack-1x fa-inverse" style="font-weight:600;">O</span>
                </span>
            {% endif %}
          ;;
    }


    measure: total_revenue {
      label: "Total Revenue USD"
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

      link: {
        label: "Show as scatter plot 2"
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

        /explore/mannyb_sandbox/order_items?fields=order_items.created_date,order_items.total_revenue&f[order_items.created_date]={{ order_items.created_date._value}}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
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


    measure: max_findings_tier_score {
      label: "Max Findings Tier"
      description: "The grantee's maximum A-133 findings tier within the filtered years, on a scale of 1 (least issues) to 5 (most issues)"
      type: string
      sql:case
            when ${count} > 0 and ${count} <= 10 then 1
             when ${count} > 10 and ${count} <= 50 then 2
             when ${count} > 50 and ${count} <= 100 then 3
             when ${count} > 100 and ${count} <= 200 then 4
             when ${count} > 200 and ${count} < 1000 then 5
        end
    ;;
  #   html:
  #   <center>

  #   {% if {{value}} == 1  %}
  #   <span class="fa-stack fa-lg">
  #   <i class="fa fa-circle fa-stack-2x" style="color:#D8BCF2"></i>
  #   <span class="fa-stack-1x fa-inverse" style="font-weight:600;">1</span>
  #   </span>
  #   {% endif %}

  #   {% if {{value}} == 2  %}
  #   <span class="fa-stack fa-lg">
  #   <i class="fa fa-circle fa-stack-2x" style="color:#AC6EE4"></i>
  #   <span class="fa-stack-1x fa-inverse" style="font-weight:600;">2</span>
  #   </span>

  #   {% endif %}

  #   {% if {{value}} == 3  %}
  #   <span class="fa-stack fa-lg">
  #   <i class="fa fa-circle fa-stack-2x" style="color:#7F1DCF"></i>
  #   <span class="fa-stack-1x fa-inverse" style="font-weight:600;">3</span>
  #   </span>
  #   {% endif %}

  #   {% if {{value}} == 4  %}
  #   <span class="fa-stack fa-lg">
  #   <i class="fa fa-circle fa-stack-2x" style="color:#521985"></i>
  #   <span class="fa-stack-1x fa-inverse" style="font-weight:600; height:80%">4</span>
  #   </span>
  #   {% endif %}

  #   {% if {{value}} == 5  %}
  # <span class="fa-stack fa-lg">
  #   <i class="fa fa-circle fa-stack-2x" style="color:#2F0E4C"></i>
  #   <span class="fa-stack-1x fa-inverse" style="font-weight:600;">5</span>
  #   </span>
  #   {% endif %}

  #   ;;



        html:
              <center>

            {% if {{value}} == 1  %}
              <span style="verical-align:top;cursor:help; font-size:9px; padding-top:2px" title="Tier 1
              Maximum tier for the filtered years on a
              scale of 1 (least issues) to 5 (most issues)">
                <span class="fa-stack fa-lg">
                  <i class="fa fa-circle fa-stack-2x" style="color:#D8BCF2"></i>
                  <span class="fa-stack-1x fa-inverse" style="font-weight:600;">1</span>
                </span>
              </span>
            {% endif %}

            {% if {{value}} == 2  %}

              <span style="verical-align:top;cursor:help; font-size:9px; padding-top:2px" title="Tier 2
              Maximum tier for the filtered years on a
              scale of 1 (least issues) to 5 (most issues)">
                <span class="fa-stack fa-lg">
                  <i class="fa fa-circle fa-stack-2x" style="color:#AC6EE4"></i>
                  <span class="fa-stack-1x fa-inverse" style="font-weight:600;">2</span>
                </span>
              </span>
            {% endif %}

            {% if {{value}} == 3  %}
              <span style="verical-align:top;cursor:help; font-size:9px; padding-top:2px" title="Tier 3
              Maximum tier for the filtered years on a
              scale of 1 (least issues) to 5 (most issues)">
                <span class="fa-stack fa-lg">
                  <i class="fa fa-circle fa-stack-2x" style="color:#7F1DCF"></i>
                  <span class="fa-stack-1x fa-inverse" style="font-weight:600;">3</span>
                </span>
              </span>
            {% endif %}

            {% if {{value}} == 4  %}
              <span style="verical-align:top;cursor:help; font-size:9px; padding-top:2px" title="Tier 4
              Maximum tier for the filtered years on a
              scale of 1 (least issues) to 5 (most issues)">
                <span class="fa-stack fa-lg">
                  <i class="fa fa-circle fa-stack-2x" style="color:#521985"></i>
                  <span class="fa-stack-1x fa-inverse" style="font-weight:600;">4</span>
                </span>
              </span>
            {% endif %}

            {% if {{value}} == 5  %}
              <span style="verical-align:top;cursor:help; font-size:9px; padding-top:2px;" title="Tier 5
              Maximum tier for the filtered years on a
              scale of 1 (least issues) to 5 (most issues)">
                <span class="fa-stack fa-lg">
                  <i class="fa fa-circle fa-stack-2x" style="color:#2F0E4C"></i>
                  <span class="fa-stack-1x fa-inverse" style="font-weight:600;">5</span>
                </span>
              </span>
            {% endif %}
            </center>;;
      }



      measure: max_findings_tier_score_2 {
        label: "Max Findings Tier"
        description: "The grantee's maximum A-133 findings tier within the filtered years, on a scale of 1 (least issues) to 5 (most issues)"
        type: string
        sql:case
            when ${count} > 0 and ${count} <= 10 then 1
             when ${count} > 10 and ${count} <= 50 then 2
             when ${count} > 50 and ${count} <= 100 then 3
             when ${count} > 100 and ${count} <= 200 then 4
             when ${count} > 200 and ${count} < 1000 then 5
        end
    ;;

          html:
              {% assign flag_value = value  %}
              @{flag_display}
              ;;
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
              <details>
                  <summary style="outline:none"> Sales Price: {{ display_more_in_tool_tip.rendered_value }}</summary>
                  <summary style="outline:none"> Average Sales Price: {{ average_sales_price._rendered_value }}</summary>
                  <summary style="outline:none">  Count of Items: {{ count._rendered_value }}</summary>
                  <summary style="outline:none">  Total Sales Price: {{ total_sales_price._rendered_value }}</summary>
                  <br/>
                  </details>;;
        }
      }
