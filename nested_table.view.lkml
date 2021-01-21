# view: persons {
#   sql_table_name: `bigquery-samples.nested.persons_living` ;;

#   dimension: id {
#     primary_key: yes
#     sql: ${TABLE}.fullName ;;
#   }
#   dimension: fullName {label: "Full Name"}
#   dimension: age {}

#   dimension: citiesLived {hidden:yes}
#   dimension: phoneNumber {hidden:yes}

#   measure: average_age {
#     type: average
#     sql: ${age} ;;
#     drill_fields: [fullName,age]
#   }
#   }


# explore: persons {
#   # Repeated nested object
#   join: persons_cities_lived {
#     view_label: "Persons: Cities Lived:"
#     sql: LEFT JOIN UNNEST(persons.citiesLived) as persons_cities_lived ;;
#     relationship: one_to_many
#   }
#   # Non repeated nested object
#   join: persons_phone_number {
#     view_label: "Persons: Phone:"
#     sql: LEFT JOIN UNNEST([${persons.phoneNumber}]) as persons_phone_number ;;
#     relationship: one_to_one
#   }
# }
