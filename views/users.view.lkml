view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: is_senior {
    type: yesno
    sql: ${age} > 60 ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [15, 25, 35, 45, 60]
    sql: ${age}  ;;
    style: interval
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
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
      year
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

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

dimension: name {
  type: string
  sql: ${first_name} || ' ' || ${last_name} ;;
}
  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: random_gen {
    type: number
    sql: random()  ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.count]
  }


  measure: senior_count {
      type: count
      filters: {
          field: is_senior
          value: "yes"
      }
  }

  # example or Tier dim
#   dimension: age_tier {
#     type: tier
#     tiers: [15, 25, 35, 45, 55, 65]
#     sql: ${age} ;;
#     style: integer
#   }

}
