view: users {
  sql_table_name: demo_db.users ;;

  filter: OR_city_filter {
    type: string
    suggest_explore: users
    suggest_dimension: users.city
  }

  filter: OR_zip_filter {
    type: string
    suggest_explore: users
    suggest_dimension: users.zip
  }

  filter:  search_field {
  type: string
  sql: ${id};;
  suggest_dimension: dummy

  }

  dimension: Apply_OR_condition {
    #  always set to YES
    type: yesno
    sql: {% condition OR_city_filter %} ${city} {% endcondition %} OR  {% condition OR_zip_filter %} ${zip} {% endcondition %}  ;;

  }

  dimension: id {
    primary_key: yes
    type: number
     sql: ${TABLE}.id ;;

  }

dimension: dummy {
  type: string
#   sql: concat (${id}, "|", ${last_name}) ;;
  sql: concat (${id}, "|", ${last_name}) ;;
}
  # dimension: variable_dim {
  #     type: string
  #     hidden: yes
  #     sql: CASE
  #             WHEN {% parameter user_city_filter %} = "zip" THEN ${zip} IS NOT NULL
  #             WHEN {% parameter user_city_filter %} = "city" THEN ${city}  IS NOT NULL
  #             WHEN {% parameter user_city_filter %} = "state" THEN ${state}  IS NOT NULL
  #         END ;;
  # }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: filter_val {
    type: string
    sql: {% parameter OR_city_filter %};;
  }


  dimension: age_tier {
    type: tier
    style: integer
    tiers: [15,25,35,50,65]
    sql: ${age} ;;
    html:
      {% if  value  == 'Below 15' %}
         Under 15
      {% endif %}
      {% if value == '15 to 24' %}
        Between 15 To 24
      {% endif %}
      {% if value == '25 to 34' %}
        Between 35 To 34
      {% endif %}
    ;;

  }

  dimension: age_display {
    type: string
    sql:

  }

  dimension: new_customer {
    type: yesno
    sql:  ${created_date} >= DATE_ADD(CURDATE(), INTERVAL -89 DAY)   ;;
#  (((users.created_at ) >= ((DATE_ADD(CURDATE(),INTERVAL -89 day))) AND (users.created_at ) < ((DATE_ADD(DATE_ADD(CURDATE(),INTERVAL -89 day),INTERVAL 90 day)))))
  }
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    #map_layer_name: my_neighborhood_layer
  }

  dimension: secondary_city {
    type: string
    sql: concat(${TABLE}.city, ' ' , ${city}) ;;
    #map_layer_name: my_neighborhood_layer
  }

  dimension: customer_first_order_date {
    type:  date
    sql: (SELECT MIN(o.created_at) FROM demo_db.orders AS o WHERE o.user_id = ${id}) ;;
  }

  dimension: customer_first_order_date_plus {
    type: date
    sql: DATE_ADD(${customer_first_order_date}, INTERVAL 365 DAY) ;;
  }


  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: days_since_signup {
    type: number
    sql: DATEDIFF(CURDATE(), ${created_date} );;
  }

  dimension: days_since_signup_tier {
    type: tier
    tiers: [30, 60, 90, 180, 270, 360, 540, 720]
    sql: ${days_since_signup} ;;
    style: integer
  }

  dimension: months_since_signup {
    type: number
    sql: FLOOR((DATEDIFF(CURDATE(), ${created_date} ))/30);;
  }


  dimension: month_since_signup_tier {
    type: tier
    tiers: [1, 3, 6, 12, 18, 24]
    sql: ${months_since_signup} ;;
    style: integer
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_month
    ]
    sql: ${TABLE}.created_at ;;
  }


  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: is_male {
    type: yesno
    sql: NULL = "M" ;;
  }

  dimension: is_city_selected {
    type: yesno
#       sql: ${secondary_city} LIKE CONCAT('%', {% parameter user_city_filter %}, '%');;
#       sql: POSITION({% parameter user_city_filter %}  IN ${secondary_city} ) > 0 ;;
    sql: POSITION(${OR_city_filter}  IN ${secondary_city} ) > 0 ;;

  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    map_layer_name: us_states
    type: string
    sql: ${TABLE}.state ;;

  }

  dimension: state_greater_100 {
    type: string

  }

  dimension: zip {
    map_layer_name: my_neighborhood_layer
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: customer_order_count {
    type: number
    #hidden: yes
    sql:  (SELECT COUNT(DISTINCT orders.id ) FROM demo_db.order_items  AS order_items
        LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
        WHERE orders.user_id = ${TABLE}.id
        GROUP BY users.id ) ;;
  }

  dimension: customer_order_tier {
    type: tier
    tiers: [1,2,3,6,10]
    style: integer
    sql: ${customer_order_count} ;;
  }

  measure: count {
    label: "Count of users"
    type: count
    drill_fields: [detail*]
  }

  measure: select_city_count {

    type: count
    filters: {
      field:  is_city_selected
      value: "yes"
    }
#     sql: ${city}  = ${filter_val}
  }

  measure: average_days_since_signup {
    type: average
    sql: ${days_since_signup} ;;
  }
  measure:  average_months_since_signup {
    type: average
    sql: FLOOR((DATEDIFF(CURDATE(), ${created_date} ))/30) ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
