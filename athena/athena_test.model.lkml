connection: "athena"

include: "/athena/*.view.lkml"                # include all views in the views/ folder in this project

datagroup: sfx_refresh {
  sql_trigger: select current_date ;;
}

explore: test_view_1  {}

explore: manny_test {}
