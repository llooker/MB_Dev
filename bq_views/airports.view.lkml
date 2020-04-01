view: airports {
  sql_table_name: `lookerdata.faa.airports`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: act_date {
    type: string
    sql: ${TABLE}.act_date ;;
  }

  dimension: aero_cht {
    type: string
    sql: ${TABLE}.aero_cht ;;
  }

  dimension: c_ldg_rts {
    type: string
    sql: ${TABLE}.c_ldg_rts ;;
  }

  dimension: cbd_dir {
    type: string
    sql: ${TABLE}.cbd_dir ;;
  }

  dimension: cbd_dist {
    type: number
    sql: ${TABLE}.cbd_dist ;;
  }

  dimension: cert {
    type: string
    sql: ${TABLE}.cert ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: cntl_twr {
    type: string
    sql: ${TABLE}.cntl_twr ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: cust_intl {
    type: string
    sql: ${TABLE}.cust_intl ;;
  }

  dimension: elevation {
    type: number
    sql: ${TABLE}.elevation ;;
  }

  dimension: faa_dist {
    type: string
    sql: ${TABLE}.faa_dist ;;
  }

  dimension: faa_region {
    type: string
    sql: ${TABLE}.faa_region ;;
  }

  dimension: fac_type {
    type: string
    sql: ${TABLE}.fac_type ;;
  }

  dimension: fac_use {
    type: string
    sql: ${TABLE}.fac_use ;;
  }

  dimension: fed_agree {
    type: string
    sql: ${TABLE}.fed_agree ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: joint_use {
    type: string
    sql: ${TABLE}.joint_use ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: major {
    type: string
    sql: ${TABLE}.major ;;
  }

  dimension: mil_rts {
    type: string
    sql: ${TABLE}.mil_rts ;;
  }

  dimension: own_type {
    type: string
    sql: ${TABLE}.own_type ;;
  }

  dimension: site_number {
    type: string
    sql: ${TABLE}.site_number ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: count {
    type: count
    drill_fields: [id, full_name]
  }

  measure: min_elevation {
    type: min
    sql: ${elevation} ;;
  }

  measure: max_elevation {
    type: max
    sql: ${elevation} ;;
  }

  measure: average_elevation {
    type: average
    sql: ${elevation} ;;
  }

#   measure: with_control_tower_count {
#     type: count
#     filters: {
#       field: control_tower
#       value: "Yes"
#     }
#   }
}
