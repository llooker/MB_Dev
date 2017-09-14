view: products {
  sql_table_name: demo_db.products ;;

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
    icon_url: "https://static.xx.fbcdn.net/rsrc.php/yl/r/H3nktOa7ZMg.ico"
  }
  }

  dimension: category {
    type: string
    sql:  ${TABLE}.category  ;;
    html: <a href="http://www.google.com/search?q={{ value }}">{{ {{value }}</a> ;;
    # "http://www.google.com/search?q=" {{link}} ;;
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
