view: test_derived_table {
  derived_table: {
    create_process: {
      sql_step:
          msck repair table public.users
      ;;

      sql_step:
        create table test_create as
        select id, email from public.users
        ;;
    }

  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
 }
