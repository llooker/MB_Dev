- dashboard: localization_mb_lk
  title: "lk_dash"
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: "lk_tile"
    name: localization_test_mb
    model: mannyb_sandbox
    explore: order_items
    type: looker_grid
    fields: [order_items.created_date, order_items.status, order_items.count, users.country]
    filters:
      order_items.created_date: 7 days
    sorts: [order_items.created_date desc]
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparency
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: "mytext.note_text"
    listen: {}
    row: 0
    col: 0
    width: 100
    height: 6

  - name: add_a_unique_name_1624287512
    title: Untitled Visualization
    model: mannyb_sandbox
    explore: order_items
    type: table
    fields: [order_items.created_date, order_items.status, order_items.count, users.country]
    filters:
      order_items.created_date: 7 days
    sorts: [order_items.created_date desc]
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: mytext.note_text
    series_types: {}
