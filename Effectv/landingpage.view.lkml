
view: landingpage {
  derived_table: {
    sql: select 1 as val ;;

  }

  dimension: image {
    sql: ${TABLE}.val ;;
    html:

      <table style="width: 150%;">
      <tr>
      <td style="width: 100%;">
     <a href="https://ibb.co/cr6mPhF"><img src="https://i.ibb.co/0GCwkyM/toplogo.png" alt="toplogo" border="0" /></a></td>
      </tr>
      <tr >
      <td align="center">
        <div class="btn-group btn-group-lg" align="center">
          <button type="button" class="btn btn-link"><a href="https://www.effectv.com/" target="_blank">Tools A-Z</a></button>
          <button type="button" class="btn btn-link"><a href="https://corporate.comcast.com/company" target="_blank">Category Tools</a></button>
          <button type="button" class="btn btn-link"><a href="/projects/training_advanced/files/alternate_available_connections.md" target="_blank">Sales Discovery</a></button>
        </div>
      </td>
      </tr>
      <tr >
      <td align="center">
        <a href="https://profservices.dev.looker.com/dashboards/451" target="_blank"><img src="https://i.ibb.co/Sy8957s/Bottom-Buttons.png" alt="Bottom-Buttons" border="0" /></a>
      </td>
      </tr>
      </table>

    ;;
  }

  dimension: imageauto {
    sql: ${TABLE}.val ;;
    html:

    <a href="https://www.effectv.com/industries/automotive" target="_blank"><img src="https://i.ibb.co/55SWppp/Automotive-Polk.png" alt="Automotive-Polk" border="0" width="100%"/></a>
    ;;
  }

  dimension: imageauto2 {
    sql: ${TABLE}.val ;;
    html:

    <a href="https://effectv.looker.com/dashboards/486" target="_blank"><img src="https://i.ibb.co/55SWppp/Automotive-Polk.png" alt="Automotive-Polk" border="0" width="100%"/></a>
    ;;
  }

  dimension: drill1 {
    type: string
    sql: ${TABLE}.val ;;
    html: "This is a test tool tip" ;;

  }
 measure: dummyM {
   type: count
   drill_fields: [drill1]
   html: <img src="https://i.ibb.co/55SWppp/Automotive-Polk.png" alt="Automotive-Polk" border="0" width="100%"/>
    ;;
 }

}
