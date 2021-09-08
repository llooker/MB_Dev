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

  dimension: report_generated_by {
  label: "Report Generated By"
  type: string
  sql:'{{_user_attributes['name']}}' ;;
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
    label: "Country"
    type: string
    sql: ${TABLE}.country ;;
#     html:
#     <h1>A Web Page</h1>
# <p id="demo">A Paragraph</p>
# <button type="button" onclick="myFunction()">Try it</button>

# <script>
# function myFunction() {
#   document.getElementById("demo").innerHTML = "Paragraph changed.";
# }
# </script>

# ;;
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

  dimension: days_since_customer {
    type: number
    sql: datediff(day, ${created_date},current_date)  ;;
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
    link: {
      label: "state lookup"
      url: "https://www.google.com?q={{_user_attributes['state']}}"
    }
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

  # dimension: url_gen {
  #   type:  string
  #   sql:
  #   {% assign company_name = _user_attributes['company'] %}
  #   {% if company_name == 'exploredx-team' %}
  #     'https://{{company_name._value}}.pdxinc.com/looks/6673'
  #   {% elsif company_name  == 'exploredx-preprod') %}
  #     'https://{{company_name._value}}.pdxinc.com/looks/18?'
  #   {% else %}
  #     'https://{{company_name._value}}.pdxinc.com/looks/16915'
  #     {% endif %}
  #   ;;
  # }

  dimension: zip_html_test {
    label: "Prescription Transaction ID"
    description: "Unique ID number identifying a transanction record within a pharmacy chain"
    type: zipcode
    sql: ${zip} ;;

#     link: {
#       label: "Workflow Task Analysis"
#       url: "https://{{ _user_attributes['company'] }}.pdxinc.com/explore/PDX_CUSTOMER_DSS/eps_task_history?fields=eps_task_history.prescription_transaction_workflow_task_analysis_detail*&f[eps_task_history.task_history_action_current_date]=&f[eps_task_history.rx_tx_id]={{ value }}&f[store_alignment.pharmacy_number]={{ _filters['store_alignment.pharmacy_number'] | url_encode }}&sorts=eps_task_history.task_history_action_current_time+desc&limit=500"
#     }

#     link: {
#
#       label: "Task Tracking Detail Report"
#       url:
#        "{% if ( _user_attributes['company']  == 'exploredx-team') %}
#       https://{{ _user_attributes['company'] }}.pdxinc.com/looks/6673?f[eps_task_history.task_history_action_current_date]=&f[eps_task_history.rx_tx_id]={{ value }}&f[store_alignment.pharmacy_number]={{ _filters['store_alignment.pharmacy_number'] | url_encode }}&sorts=eps_task_history.task_history_action_current_time+desc&limit=500
#       {% elsif ( _user_attributes['company']  == 'exploredx-preprod')%}
#       https://{{ _user_attributes['company'] }}.pdxinc.com/looks/18?f[eps_task_history.task_history_action_current_date]=&f[eps_task_history.rx_tx_id]={{ value }}&f[store_alignment.pharmacy_number]={{ _filters['store_alignment.pharmacy_number'] | url_encode }}&sorts=eps_task_history.task_history_action_current_time+desc&limit=500
#       {% else %}
#       https://{{ _user_attributes['company'] }}.pdxinc.com/looks/16915?f[eps_task_history.task_history_action_current_date]=&f[eps_task_history.rx_tx_id]={{ value }}&f[store_alignment.pharmacy_number]={{ _filters['store_alignment.pharmacy_number'] | url_encode }}&sorts=eps_task_history.task_history_action_current_time+desc&limit=500
#       {% endif %}"
#
#     }

    # link: {
    #   label: "Task Tracking Detail Report"
    #   url: "{{ url_gen._value}}f[eps_task_history.task_history_action_current_date]=&f[eps_task_history.rx_tx_id]={{ value }}&f[store_alignment.pharmacy_number]={{ _filters['store_alignment.pharmacy_number'] | url_encode }}&sorts=eps_task_history.task_history_action_current_time+desc&limit=500"
    # }
  }

  # example or Tier dim
#   dimension: age_tier {
#     type: tier
#     tiers: [15, 25, 35, 45, 55, 65]
#     sql: ${age} ;;
#     style: integer
#   }

}
