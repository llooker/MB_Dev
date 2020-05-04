- dashboard: testlookmldashboard
  title: Testlookmldashboard
  layout: newspaper
#   tile_size: 100

# - dashboard: Customer Behaviour
#  layout: newspaper
  elements:
  - name: Cohort - Average revenue/spend by customer longitivtiy
    label: Cohort - Average revenue/spend by customer longitivtiy
    model: fashionly_mb
    explore: order_items
    type: looker_line
    fields:
    - order_items.average_spend_per_customer
    - users.days_since_signup_tier
    fill_fields:
    - users.days_since_signup_tier
    sorts:
    - users.days_since_signup_tier
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    font_size: '12'
    value_labels: legend
    label_type: labPer
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    series_labels:
      order_items.average_spend_per_customer: Average Spend
      order_items.total_adjusted_revenue: Total Adjusted Revenue
    y_axes:
    - label: Total Adjusted Revenue
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: order_items.total_adjusted_revenue
        name: Total Adjusted Revenue
    - label: Average Spend
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: order_items.average_spend_per_customer
        name: Average Spend
    x_axis_label: Months Since Signup
    reference_lines: []
    hidden_fields:
    hidden_series:
    - order_items.total_adjusted_revenue
    listen: {}
    row: 0
    col: 0
    width: 12
    height: 8
  - name: Cohort - Customer Value over time of signup
    label: Cohort - Customer Value over time of signup
    model: fashionly_mb
    explore: order_items
    type: looker_line
    fields:
    - order_items.average_gross_margin
    - users.months_since_signup
    sorts:
    - users.months_since_signup desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 23
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: circle
    interpolation: step-before
    discontinuous_nulls: false
    reference_lines: []
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    y_axes:
    - label: Average Gross Margin
      maxValue:
      minValue: -10
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: order_items.average_gross_margin
        name: Order Items Average Gross Margin
    x_axis_label: Months Since Signup
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types: {}
    listen: {}
    row: 0
    col: 12
    width: 12
    height: 8
  - name: Cohort - Customer Value 1 Month vs 1 Year since sign up
    label: Cohort - Customer Value 1 Month vs 1 Year since sign up
    model: fashionly_mb
    explore: order_items
    type: looker_pie
    fields:
    - order_items.average_spend_per_customer
    - users.months_since_signup
    filters:
      users.months_since_signup: '1,12'
    sorts:
    - order_items.average_spend_per_customer desc
    - users.months_since_signup
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    show_value_labels: false
    font_size: 12
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: circle
    interpolation: linear
    series_types: {}
    listen: {}
    row: 8
    col: 0
    width: 12
    height: 8
  - name: cohort - Percentage of Active Customers for given signup month
    label: cohort - Percentage of Active Customers for given signup month
    model: fashionly_mb
    explore: order_items
    type: single_value
    fields:
    - customer_counts.count_of_active_customer
    - users.count
    filters:
      users.months_since_signup: '24'
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: percentage_active_customers
      label: Percentage Active Customers
      expression: 1.0 * ${customer_counts.count_of_active_customer}/${users.count}
      value_format:
      value_format_name: percent_2
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    row: 8
    col: 12
    width: 12
    height: 8
  - name: Cohort - Active customer behavior over time
    label: Cohort - Active customer behavior over time
    model: fashionly_mb
    explore: order_items
    type: looker_line
    fields:
    - users.months_since_signup
    - customer_counts.count_of_active_customer
    sorts:
    - customer_counts.count_of_active_customer desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    listen: {}
    row:
    col:
    width:
    height:
