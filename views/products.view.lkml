
view: products {
  sql_table_name: public.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
      icon_url: "https://upload.wikimedia.org/wikipedia/commons/c/c2/F_icon.svg"
    }

    # link: {
    #   label: "{{value}} Analytics Dashboard"
    #   url: "/dashboards/lUUVihaIO8haWkmECYYPzF?Brand={{ value | encode_uri }}&State={{ _filters['users.state'] }}"
    #   icon_url: "http://www.looker.com/favicon.ico"
    # }

    # link: {
    #   label: "{{value}} Category Look"
    #   url: "/looks/517?f[products.brand]={{ value | encode_uri }}&f[users.state]={{ _filters['users.state'] }}"
    #   icon_url: "http://www.looker.com/favicon.ico"
    # }

    # link: {
    #   label: "Explore Users"
    #   url: "/explore/mannyb_sandbox/order_items?fields=users.id,users.name&f[products.brand]={{ value | encode_uri }}&f[users.state]={{ _filters['users.state'] }}"
    #   icon_url: "http://www.looker.com/favicon.ico"
    # }


    drill_fields: [category, name]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
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
    drill_fields: [id, name]
  }
}
