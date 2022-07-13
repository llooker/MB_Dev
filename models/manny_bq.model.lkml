connection: "biquery_publicdata_standard_sql"
include: "/bq_views/*.view"


datagroup: hourly {
  sql_trigger: SELECT hour(now() ;;
}
explore: aircraft {
}


explore: +aircraft {
  aggregate_table: rollup__name {
    query: {
      dimensions: [name]
      measures: [count]
      timezone: "America/New_York"
    }
    materialization: {
      datagroup_trigger: hourly
    }
    # Please specify a datagroup_trigger or sql_trigger_value
    # See https://looker.com/docs/r/lookml/types/aggregate_table/materialization
  }
}
