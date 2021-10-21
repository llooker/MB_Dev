

view: dynamic_table {
 derived_table: {
   sql:
    WITH base AS
    ( SELECT
     {% parameter filter_dimension %} column_name
    FROM
      public.products
    WHERE
      {% condition filter_dimension_values %} {% parameter filter_dimension %} {% endcondition %}
    ), list_1 AS
    (SELECT
      listagg(distinct column_name, ',') column_name_list,
      array_agg(distinct column_name) column_name_array
    FROM base)

    SELECT base.*, list_1.*
    from base cross join list_1
     ;;
}

  parameter: filter_dimension {
    type: unquoted
    allowed_value: {label: "Brand" value:"brand"}
    allowed_value: {label: "Category" value:"category"}
    default_value: "brand"
  }

  filter: filter_dimension_values {
    type: string
  }

  dimension: column_name {
    type: string
    label_from_parameter: filter_dimension
    sql: ${TABLE}.column_name ;;
  }

  dimension: column_name_list {}

  dimension: column_name_array {}

  dimension: test {
    type: string
    sql:  {{ column_name_list._value | split:"," | sql_quote | join:"," }} ;;
  }

  dimension: value_1 {
    type: string
     label: "{{column_name._value }} "
     sql: ${TABLE}.column_name ;;
  }

  measure: filter_value_1 {
    type: number
    # label: "{% assign val = column_name_array[0]' %} {{val._value }} "
    # label: "{{ dynamic_table.column_name._value }}"
    sql: {% assign val = "Levi's" %}
         {% if products.brand == 'Levi''s' %}
          SUM (1)
         {% else %}
          SUM (0)
          {% endif %};;
  }

  measure: filter_value_2 {
    type: number
    sql:  {% assign val = column_name_array[1] %}
    {% if products.brand == {{val }} %}
    SUM (1)
    {% else %}
    SUM (0)
    {% endif %};;
  }

  measure: filter_value_3 {
    type: number
    sql: {% assign val = column_name_array[2] %}
    {% if products.brand == {{val }} %}
    SUM (1)
    {% else %}
    SUM (0)
    {% endif %};;
  }

}
