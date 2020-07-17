view: test_view_1 {
  derived_table: {
    datagroup_trigger: sfx_refresh
    create_process: {
      sql_step:  msck repair table looker_test.orders ;;

      sql_step:
        create external table if not exists looker_test_scratch.manny_test (
          created_at date,
          order_count bigint
          )
          location 's3://looker-athena-scratch/helltool-dialect-test;'
        ;;

      sql_step:
        insert into looker_test_scratch.manny_test (created_at, order_count)
        select cast(created_at as date) created_date,
                count(*)
              from looker_test.orders
              where cast(created_at as date) >= (select cast(max(created_at) as date) max_date from looker_test.orders )
              group by 1;;



    }
    }
      dimension: rowcount {}
    }
