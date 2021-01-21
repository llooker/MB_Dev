connection: "thelook_events_redshift"

# include all views in this project
#- include: "*.dashboard.lookml"  # include all dashboards in this project
include: "/*/*.view"

explore: hr_looker_training_set {}

view: hr_looker_training_set {
  derived_table: {
    sql: select
      1 as employee_number,
      'Joan of Arc' as name,
      'Executive' as department,
      35000 as salary,
      2008 as hired_year,
      'F' as gender

      union all

      select
      2 as employee_number,
      'Winston Churchill' as name,
      'Executive' as department,
      25000 as salary,
      2009 as hired_year,
      'M' as gender

      union all

      select
      3 as employee_number,
      'Karl Marx' as name,
      'Finance' as department,
      25000 as salary,
      2009 as hired_year,
      'M' as gender

      union all

      select
      4 as employee_number,
      'Mother Teresa' as name,
      'HR' as department,
      16000 as salary,
      2010 as hired_year,
      'F' as gender

      union all

      select
      5 as employee_number,
      'Barbra Streisand' as name,
      'Sales' as department,
      16000 as salary,
      2010 as hired_year,
      'F' as gender

      union all

      select
      6 as employee_number,
      'Elvis Presley' as name,
      'Sales' as department,
      8000 as salary,
      2012 as hired_year,
      'M' as gender

      union all

      select
      7 as employee_number,
      'Katy Perry' as name,
      'Analytics' as department,
      8000 as salary,
      2012 as hired_year,
      'F' as gender

      union all

      select
      8 as employee_number,
      'Justin Bieber' as name,
      'Analytics' as department,
      8000 as salary,
      2012 as hired_year,
      'M' as gender


      union all

      select
      8 as employee_number,
      'M & M' as name,
      'Analytics' as department,
      8000 as salary,
      2012 as hired_year,
      'M' as gender

      union all

      select
      8 as employee_number,
      'Bob O,brian' as name,
      'Analytics' as department,
      8000 as salary,
      2012 as hired_year,
      'M' as gender
       ;;

  }

  ##  DIMENSIONS  ##

  dimension: employee_number {
    sql: ${TABLE}.employee_number ;;
  }

  dimension: name {
    sql: ${TABLE}.name ;;
  }

  dimension: department {
    sql: ${TABLE}.department ;;
  }

  dimension: salary {
    type: number
    sql: coalesce(${TABLE}.salary,0) ;;
    value_format: "$#,##0"
  }

  dimension: gender {
    sql: ${TABLE}.gender ;;
  }

  dimension: hired_year {
    sql: ${TABLE}.hired_year ;;
  }

  dimension: years_employed {
    type: number
    sql: coalesce(cast(extract(year from current_date) - ${hired_year} as decimal),0) ;;
  }

  ##  MEASURES  ##

  measure: employee_count {
    type: count
    drill_fields: [detail*]
  }

  measure: department_count {
    type: count_distinct
    sql: ${department} ;;
  }

  measure: salary_count {
    type: count_distinct
    sql: ${salary} ;;
  }

  measure: average_salary {
    type: average
    value_format: "$#,##0"
    sql: ${salary} ;;
  }

  measure: total_salary {
    type: sum
    value_format: "$#,##0"
    sql: ${salary} ;;
  }

  measure: average_years_employed {
    type: average
    sql: ${years_employed} ;;
  }

  measure: total_years_employed {
    type: sum
    sql: ${years_employed} ;;
  }

  set: detail {
    fields: [employee_number, name, department, salary, hired_year]
  }
}
