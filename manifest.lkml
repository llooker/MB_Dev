project_name: "mannyb_sandbox"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: 'name_of_other_project'
# }



constant: flag_display {
  value: "

    <center>
    {% if {{flag_value}} == 1  %}
      <span style='verical-align:top;cursor:help; font-size:9px; padding-top:2px' title='Tier 1
      Maximum tier for the filtered years on a
      scale of 1 (least issues) to 5 (most issues)'>
        <span class='fa-stack fa-lg'>
          <i class='fa fa-circle fa-stack-2x' style='color:#D8BCF2'></i>
          <span class='fa-stack-1x fa-inverse' style='font-weight:600;'>1</span>
        </span>
      </span>
    {% endif %}

    {% if {{flag_value}} == 2  %}

      <span style='verical-align:top;cursor:help; font-size:9px; padding-top:2px' title='Tier 2
      Maximum tier for the filtered years on a
      scale of 1 (least issues) to 5 (most issues)'>
        <span class='fa-stack fa-lg'>
          <i class='fa fa-circle fa-stack-2x' style='color:#AC6EE4'></i>
          <span class='fa-stack-1x fa-inverse' style='font-weight:600;'>2</span>
        </span>
      </span>
    {% endif %}

    {% if {{flag_value}} == 3  %}
      <span style='verical-align:top;cursor:help; font-size:9px; padding-top:2px' title='Tier 3
      Maximum tier for the filtered years on a
      scale of 1 (least issues) to 5 (most issues)'>
        <span class='fa-stack fa-lg'>
          <i class='fa fa-circle fa-stack-2x' style='color:#7F1DCF'></i>
          <span class='fa-stack-1x fa-inverse' style='font-weight:600;'>3</span>
        </span>
      </span>
    {% endif %}

    {% if {{flag_value}} == 4  %}
      <span style='verical-align:top;cursor:help; font-size:9px; padding-top:2px' title='Tier 4
      Maximum tier for the filtered years on a
      scale of 1 (least issues) to 5 (most issues)'>
        <span class='fa-stack fa-lg'>
          <i class='fa fa-circle fa-stack-2x' style='color:#521985'></i>
          <span class='fa-stack-1x fa-inverse' style='font-weight:600;'>4</span>
        </span>
      </span>
    {% endif %}

    {% if {{flag_value}} == 5  %}
      <span style='verical-align:top;cursor:help; font-size:9px; padding-top:2px;' title='Tier 5
      Maximum tier for the filtered years on a
      scale of 1 (least issues) to 5 (most issues)'>
        <span class='fa-stack fa-lg'>
          <i class='fa fa-circle fa-stack-2x' style='color:#2F0E4C'></i>
          <span class='fa-stack-1x fa-inverse' style='font-weight:600;'>5</span>
        </span>
      </span>
    {% endif %}
    </center>

"

}
