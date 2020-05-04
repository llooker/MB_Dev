view: products {
  sql_table_name: demo_db.products ;;


  filter: brand_filter {
    type: string
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: url_string {
    type: string
    sql:  {% if _explore._name == 'order_items' %}
          "/looks/74?&f[products.brand_filter]={{ brand._value | encode_uri }}"
          {% else %}
          ""
          {% endif %} ;;
#     sql: "/looks/74?&f[products.brand_filter]={{ brand._value | encode_uri }}" ;;
  }


  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;

    link: {
    label: "Website"
    url: "http://www.google.com/search?q={{ value | encode_uri }}+clothes&btnI"
    icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | encode_uri }}.com"
  }

  link: {
    label: "Facebook"
    url: "http://www.google.com/search?q=site:facebook.com+{{ value | encode_uri }}+clothes&btnI"
    icon_url: "https://static.xx.fbcdn.net/rsrc.php/yl/r/H3nktOa7ZMg.ico"
  }

    link: {
      label: "Products By Brand"
        url: "{{ url_string._rendered_value }}"

#        url: "/dashboards/20?Brand%20Filter={{ value | encode_uri }}"
      # icon_url: "https://static.xx.fbcdn.net/rsrc.php/yl/r/H3nktOa7ZMg.ico"
    }
  }

  dimension: category {
    type: string
    sql:  ${TABLE}.category  ;;
    html: <a href="http://www.google.com/search?q={{ value | encode_uri }}"> {{value }}</a> ;;
    # "http://www.google.com/search?q=" {{link}} ;;
#     html:  Category Name "{{value}}"  ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
