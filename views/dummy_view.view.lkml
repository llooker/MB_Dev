view: dummy_view {
  derived_table: {
    sql:
    SELECT 1 as dim ;;
  }


dimension: mood_tile{
  type: number
#  sql: '{{_user_attributes["looker_home_page_permissions"]}}' ;;
  sql: ${TABLE}.dim ;;
  html:
{{_user_attributes['looker_home_page_permissions']}}
  {% if {{_user_attributes['looker_home_page_permissions']}} == "Mood_test_general_user" %}
    <div>
    <font color="Aquamarine"><i class="fa fa-bar-chart-o fa-2x" vertical-align="bottom"></i></font>
    <div>
    <a href="/dashboards/opioid_overdose::prescriber_list"><font style="font-size:20px">Medicare Opioid Overdose Dashboard (MOOD)</font></a>
    <br><font style="font-size:15px;">(Authorized Access Only)</font>
    </div>
    </div>
  {% else %}
    No dashboard to show
  {% endif %}
  ;;
}

dimension: ed_tile {
    type: number
    sql: ${TABLE}.dim ;;
    html:
      {% if {{_user_attributes['looker_home_page_permissions']}} == "ed_test_general_user" %}
        <div>
        <font color=SkyBlue><i class='fa fa-bar-chart-o fa-2x'></i></font><div>
        <a href='/projects/hhs_oig_operational_insights/documents/home.md'><font style="font-size:20px">Enterprise Dashboard</font></a>
        <br><font style="font-size:15px;">(Authorized Access Only)</font>
        </div>
        </div>
      {% else %}
        No dashboard to show
      {% endif %}
      ;;
  }


 }
