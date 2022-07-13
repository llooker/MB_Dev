connection: "thelook_events_redshift"

explore: all_forms {
}

view: all_forms {
  sql_table_name:
    (
    SELECT
     {% assign param = all_forms._passthrough._sql %}
     {% assign fields = param | replace: "select", ""| replace: "'", "" | split: "," %}
     {% assign num = 0 %}
        {% for field in fields %}
          {% assign num = num | plus: 1 %}
          {% if fields.last == field %}
            {{ field | append: " as f" | append: num }}
          {% else %}
            {{ field | append: " as f" | append: num | append: ", " }}
          {% endif %}
        {% endfor %}
    FROM
    (
    select 0 as user_id, 1294 as form_id, 'green' as question_1, 'orange' as question_2, 'Lilly' as question_3, 'fish' as question_4, 'red' as question_5, 'banana'as question_6, 'Jennifer' as question_7, 'whiskey' as question_8, 'fish' as question_9, 'green' as question_10, 'orange' as question_11, 'Lilly' as question_12, 'gin' as question_13, 'dog' as question_14, 'green' as question_15, 'apple'as question_16, 'Robert' as question_17, 'gin' as question_18, 'cat' as question_19, 'green' as question_20, 'banana'as question_21, 'Mike' as question_22, 'rum' as question_23, 'snake' as question_24, 'green' as question_25, 'orange' as question_26, 'John' as question_27, 'gin' as question_28, 'snake' as question_29, 'blue' as question_30, 'apple'as question_31, 'Robert' as question_32, 'gin' as question_33, 'cat' as question_34, 'blue' as question_35, 'orange' as question_36, 'Mike' as question_37, 'whiskey' as question_38, 'hamster' as question_39, 'purple' as question_40, 'apple'as question_41, 'Lilly' as question_42, 'rum' as question_43, 'snake' as question_44, 'yellow' as question_45, 'banana'as question_46, 'Robert' as question_47, 'vodka' as question_48, 'orange' as question_49, 'Mike' as question_50, 'whiskey' as question_51, 'hamster' as question_52, 'purple' as question_53 UNION ALL
    select 2, 1276, 'orange', 'John', 'gin', 'cat', 'blue', 'orange', 'Jennifer', 'tequila', 'hamster', 'purple', 'orange', 'John', 'tequila', 'fish', 'green', 'orange', 'Lilly', 'vodka', 'hamster', 'green', 'orange', 'John', 'rum', 'hamster', 'green', 'orange', 'Jennifer', 'whiskey', 'dog', 'purple', 'orange', 'Lilly', 'whiskey', 'fish', 'yellow', 'orange', 'Jennifer', 'tequila', 'dog', 'blue', 'orange', 'Mike', 'gin', 'hamster', 'green', 'orange', 'Robert', 'tequila', 'dog', 'blue', 'orange', 'Mike', 'vodka' UNION ALL
    select 3, 1497, 'banana','Robert', 'vodka', 'fish', 'green', 'banana','Lilly', 'vodka', 'dog', 'blue', 'banana','Robert', 'gin', 'fish', 'purple', 'banana','Robert', 'rum', 'cat', 'purple', 'banana','Mike', 'gin', 'dog', 'blue', 'banana','Mike', 'rum', 'cat', 'red', 'banana','Robert', 'whiskey', 'snake', 'red', 'banana','Robert', 'vodka', 'hamster', 'purple', 'banana','Robert', 'whiskey', 'dog', 'red', 'banana','John', 'tequila', 'cat', 'purple', 'banana','Mike', 'whiskey' UNION ALL
    select 4, 1668, 'apple','Mike', 'gin', 'cat', 'purple', 'apple','Jennifer', 'gin', 'cat', 'green', 'apple','Mike', 'gin', 'dog', 'yellow', 'apple','John', 'gin', 'hamster', 'red', 'apple','Lilly', 'whiskey', 'snake', 'blue', 'apple','Lilly', 'rum', 'fish', 'purple', 'apple','Lilly', 'vodka', 'fish', 'green', 'apple','Robert', 'tequila', 'snake', 'blue', 'apple','Jennifer', 'vodka', 'fish', 'green', 'apple','John', 'rum', 'hamster', 'blue', 'apple','John', 'gin' UNION ALL
    select 5, 1989, 'orange', 'Mike', 'vodka', 'snake', 'red', 'orange', 'Mike', 'rum', 'fish', 'green', 'orange', 'Jennifer', 'rum', 'fish', 'blue', 'orange', 'John', 'vodka', 'cat', 'green', 'orange', 'Robert', 'whiskey', 'hamster', 'green', 'orange', 'Jennifer', 'tequila', 'dog', 'blue', 'orange', 'John', 'vodka', 'fish', 'purple', 'orange', 'John', 'tequila', 'dog', 'purple', 'orange', 'Lilly', 'vodka', 'cat', 'yellow', 'orange', 'John', 'tequila', 'hamster', 'yellow', 'orange', 'John', 'tequila' UNION ALL
    select 6, 1514, 'banana','Mike', 'rum', 'hamster', 'green', 'banana','Robert', 'rum', 'fish', 'purple', 'banana','Robert', 'tequila', 'snake', 'red', 'banana','Robert', 'gin', 'snake', 'green', 'banana','Lilly', 'vodka', 'cat', 'yellow', 'banana','John', 'vodka', 'cat', 'green', 'banana','Jennifer', 'rum', 'cat', 'blue', 'banana','John', 'gin', 'snake', 'yellow', 'banana','Lilly', 'rum', 'snake', 'red', 'banana','John', 'vodka', 'cat', 'green', 'banana','Mike', 'vodka' UNION ALL
    select 7, 1710, 'apple','Robert', 'gin', 'cat', 'red', 'apple','Robert', 'rum', 'snake', 'purple', 'apple','Robert', 'gin', 'snake', 'yellow', 'apple','Mike', 'whiskey', 'dog', 'green', 'apple','Mike', 'whiskey', 'cat', 'purple', 'apple','Mike', 'tequila', 'cat', 'red', 'apple','Mike', 'tequila', 'cat', 'purple', 'apple','Mike', 'rum', 'hamster', 'purple', 'apple','Mike', 'gin', 'snake', 'red', 'apple','John', 'whiskey', 'dog', 'green', 'apple','John', 'gin' UNION ALL
    select 8, 1170, 'orange', 'Mike', 'tequila', 'fish', 'red', 'orange', 'John', 'rum', 'cat', 'blue', 'orange', 'John', 'rum', 'fish', 'red', 'orange', 'Robert', 'vodka', 'fish', 'purple', 'orange', 'Jennifer', 'whiskey', 'cat', 'green', 'orange', 'Lilly', 'tequila', 'cat', 'purple', 'orange', 'Lilly', 'whiskey', 'fish', 'purple', 'orange', 'Lilly', 'rum', 'hamster', 'blue', 'orange', 'John', 'tequila', 'fish', 'yellow', 'orange', 'John', 'tequila', 'cat', 'purple', 'orange', 'Lilly', 'rum' UNION ALL
    select 9, 1696, 'banana','John', 'whiskey', 'hamster', 'blue', 'banana','John', 'vodka', 'hamster', 'purple', 'banana','John', 'vodka', 'hamster', 'yellow', 'banana','Lilly', 'gin', 'cat', 'red', 'banana','Mike', 'vodka', 'snake', 'green', 'banana','Jennifer', 'vodka', 'dog', 'red', 'banana','Mike', 'gin', 'cat', 'blue', 'banana','Mike', 'whiskey', 'hamster', 'yellow', 'banana','Robert', 'tequila', 'hamster', 'red', 'banana','John', 'rum', 'hamster', 'purple', 'banana','John', 'gin' UNION ALL
    select 10, 1703, 'apple','John', 'whiskey', 'snake', 'green', 'apple','Mike', 'whiskey', 'hamster', 'green', 'apple','John', 'vodka', 'fish', 'red', 'apple','Jennifer', 'tequila', 'hamster', 'green', 'apple','Lilly', 'gin', 'hamster', 'green', 'apple','Robert', 'gin', 'hamster', 'blue', 'apple','John', 'vodka', 'hamster', 'red', 'apple','John', 'gin', 'hamster', 'yellow', 'apple','Mike', 'gin', 'hamster', 'red', 'apple','John', 'tequila', 'dog', 'green', 'apple','Mike', 'rum' UNION ALL
    select 11, 1814, 'orange', 'Lilly', 'tequila', 'snake', 'purple', 'orange', 'Jennifer', 'gin', 'dog', 'green', 'orange', 'John', 'gin', 'cat', 'yellow', 'orange', 'Robert', 'gin', 'cat', 'red', 'orange', 'Jennifer', 'tequila', 'fish', 'green', 'orange', 'Mike', 'whiskey', 'snake', 'green', 'orange', 'Robert', 'gin', 'snake', 'red', 'orange', 'Mike', 'whiskey', 'hamster', 'blue', 'orange', 'Robert', 'tequila', 'dog', 'yellow', 'orange', 'Robert', 'tequila', 'cat', 'yellow', 'orange', 'Mike', 'vodka' UNION ALL
    select 12, 1329, 'banana','Mike', 'gin', 'hamster', 'yellow', 'banana','Mike', 'vodka', 'dog', 'yellow', 'banana','Mike', 'vodka', 'cat', 'blue', 'banana','Mike', 'tequila', 'fish', 'yellow', 'banana','Robert', 'whiskey', 'snake', 'green', 'banana','Lilly', 'gin', 'hamster', 'blue', 'banana','John', 'vodka', 'dog', 'red', 'banana','Jennifer', 'vodka', 'cat', 'yellow', 'banana','Jennifer', 'whiskey', 'hamster', 'blue', 'banana','Mike', 'tequila', 'fish', 'yellow', 'banana','Mike', 'gin' UNION ALL
    select 13, 1550, 'apple','Jennifer', 'whiskey', 'snake', 'purple', 'apple','Lilly', 'gin', 'dog', 'yellow', 'apple','Jennifer', 'vodka', 'hamster', 'blue', 'apple','Jennifer', 'gin', 'dog', 'yellow', 'apple','Jennifer', 'whiskey', 'fish', 'blue', 'apple','Robert', 'gin', 'snake', 'red', 'apple','Lilly', 'rum', 'dog', 'red', 'apple','Lilly', 'vodka', 'snake', 'yellow', 'apple','John', 'whiskey', 'dog', 'yellow', 'apple','John', 'vodka', 'fish', 'purple', 'apple','Robert', 'rum' UNION ALL
    select 14, 1776, 'orange', 'Jennifer', 'tequila', 'cat', 'purple', 'orange', 'Jennifer', 'tequila', 'hamster', 'blue', 'orange', 'Mike', 'rum', 'cat', 'yellow', 'orange', 'John', 'gin', 'dog', 'green', 'orange', 'Robert', 'gin', 'hamster', 'red', 'orange', 'Mike', 'rum', 'dog', 'yellow', 'orange', 'Lilly', 'rum', 'cat', 'green', 'orange', 'Jennifer', 'gin', 'fish', 'yellow', 'orange', 'Mike', 'whiskey', 'fish', 'blue', 'orange', 'John', 'vodka', 'dog', 'yellow', 'orange', 'Robert', 'tequila' UNION ALL
    select 15, 1288, 'banana','Jennifer', 'gin', 'dog', 'blue', 'banana','Lilly', 'whiskey', 'snake', 'green', 'banana','Jennifer', 'vodka', 'hamster', 'purple', 'banana','Mike', 'whiskey', 'hamster', 'yellow', 'banana','Robert', 'vodka', 'snake', 'purple', 'banana','Lilly', 'gin', 'fish', 'yellow', 'banana','John', 'rum', 'hamster', 'blue', 'banana','Lilly', 'rum', 'dog', 'red', 'banana','Robert', 'whiskey', 'dog', 'green', 'banana','Lilly', 'tequila', 'hamster', 'purple', 'banana','Lilly', 'whiskey' UNION ALL
    select 16, 1822, 'apple','Jennifer', 'tequila', 'hamster', 'purple', 'apple','Lilly', 'vodka', 'cat', 'yellow', 'apple','Lilly', 'whiskey', 'hamster', 'blue', 'apple','Robert', 'rum', 'snake', 'red', 'apple','Lilly', 'vodka', 'snake', 'purple', 'apple','John', 'vodka', 'fish', 'green', 'apple','Robert', 'vodka', 'dog', 'yellow', 'apple','John', 'rum', 'hamster', 'blue', 'apple','Jennifer', 'gin', 'snake', 'purple', 'apple','John', 'gin', 'fish', 'blue', 'apple','Robert', 'rum' UNION ALL
    select 17, 1385, 'orange', 'Mike', 'whiskey', 'snake', 'green', 'orange', 'Lilly', 'vodka', 'cat', 'blue', 'orange', 'Jennifer', 'whiskey', 'dog', 'yellow', 'orange', 'Jennifer', 'tequila', 'snake', 'yellow', 'orange', 'Mike', 'whiskey', 'hamster', 'yellow', 'orange', 'Robert', 'gin', 'hamster', 'red', 'orange', 'Lilly', 'whiskey', 'snake', 'red', 'orange', 'Lilly', 'gin', 'snake', 'purple', 'orange', 'John', 'tequila', 'hamster', 'green', 'orange', 'Mike', 'rum', 'dog', 'purple', 'orange', 'Jennifer', 'rum' UNION ALL
    select 18, 1424, 'banana','Jennifer', 'rum', 'dog', 'red', 'banana','Mike', 'whiskey', 'hamster', 'red', 'banana','Mike', 'vodka', 'dog', 'yellow', 'banana','Mike', 'rum', 'hamster', 'yellow', 'banana','John', 'gin', 'fish', 'blue', 'banana','Jennifer', 'vodka', 'fish', 'green', 'banana','Lilly', 'vodka', 'dog', 'purple', 'banana','Robert', 'whiskey', 'hamster', 'green', 'banana','Robert', 'gin', 'dog', 'yellow', 'banana','John', 'tequila', 'dog', 'red', 'banana','John', 'whiskey' UNION ALL
    select 19, 1462, 'apple','Lilly', 'rum', 'snake', 'blue', 'apple','Mike', 'gin', 'fish', 'purple', 'apple','John', 'gin', 'cat', 'purple', 'apple','Jennifer', 'vodka', 'fish', 'purple', 'apple','Mike', 'vodka', 'hamster', 'green', 'apple','Lilly', 'whiskey', 'snake', 'yellow', 'apple','Lilly', 'rum', 'hamster', 'blue', 'apple','Robert', 'tequila', 'cat', 'green', 'apple','John', 'tequila', 'fish', 'purple', 'apple','Lilly', 'whiskey', 'cat', 'green', 'apple','John', 'gin' UNION ALL
    select 20, 1746, 'orange', 'Lilly', 'tequila', 'snake', 'yellow', 'orange', 'Jennifer', 'vodka', 'dog', 'red', 'orange', 'Mike', 'whiskey', 'dog', 'red', 'orange', 'John', 'rum', 'fish', 'purple', 'orange', 'John', 'tequila', 'snake', 'purple', 'orange', 'Robert', 'rum', 'dog', 'green', 'orange', 'Lilly', 'tequila', 'fish', 'purple', 'orange', 'Lilly', 'tequila', 'dog', 'blue', 'orange', 'Mike', 'vodka', 'snake', 'red', 'orange', 'Jennifer', 'vodka', 'snake', 'red', 'orange', 'John', 'vodka' UNION ALL
    select 21, 1718, 'banana','Robert', 'gin', 'fish', 'red', 'banana','Lilly', 'gin', 'cat', 'purple', 'banana','Robert', 'gin', 'hamster', 'purple', 'banana','John', 'tequila', 'cat', 'purple', 'banana','John', 'whiskey', 'cat', 'purple', 'banana','Jennifer', 'gin', 'hamster', 'green', 'banana','Mike', 'vodka', 'fish', 'purple', 'banana','Jennifer', 'whiskey', 'snake', 'yellow', 'banana','Lilly', 'gin', 'hamster', 'yellow', 'banana','John', 'vodka', 'dog', 'purple', 'banana','Lilly', 'vodka' UNION ALL
    select 22, 1160, 'apple','Jennifer', 'gin', 'hamster', 'blue', 'apple','Lilly', 'whiskey', 'fish', 'yellow', 'apple','Lilly', 'rum', 'hamster', 'yellow', 'apple','Jennifer', 'gin', 'dog', 'yellow', 'apple','Lilly', 'whiskey', 'dog', 'blue', 'apple','John', 'rum', 'dog', 'green', 'apple','Mike', 'gin', 'cat', 'yellow', 'apple','Mike', 'gin', 'dog', 'blue', 'apple','Jennifer', 'whiskey', 'cat', 'red', 'apple','Jennifer', 'rum', 'fish', 'green', 'apple','Jennifer', 'gin' UNION ALL
    select 23, 1455, 'orange', 'Lilly', 'rum', 'snake', 'purple', 'orange', 'John', 'tequila', 'snake', 'blue', 'orange', 'Jennifer', 'whiskey', 'cat', 'green', 'orange', 'Jennifer', 'gin', 'hamster', 'red', 'orange', 'Jennifer', 'rum', 'dog', 'red', 'orange', 'Lilly', 'gin', 'fish', 'green', 'orange', 'John', 'vodka', 'hamster', 'yellow', 'orange', 'Mike', 'tequila', 'dog', 'purple', 'orange', 'Lilly', 'whiskey', 'snake', 'yellow', 'orange', 'Lilly', 'vodka', 'dog', 'purple', 'orange', 'Mike', 'tequila' UNION ALL
    select 24, 1815, 'banana','Robert', 'gin', 'fish', 'blue', 'banana','Robert', 'vodka', 'snake', 'purple', 'banana','John', 'vodka', 'hamster', 'purple', 'banana','Robert', 'gin', 'hamster', 'blue', 'banana','Robert', 'whiskey', 'dog', 'green', 'banana','Robert', 'rum', 'cat', 'yellow', 'banana','John', 'vodka', 'hamster', 'purple', 'banana','Jennifer', 'tequila', 'fish', 'purple', 'banana','Robert', 'gin', 'cat', 'purple', 'banana','Lilly', 'gin', 'cat', 'yellow', 'banana','John', 'vodka' UNION ALL
    select 25, 1031, 'apple','Mike', 'tequila', 'fish', 'purple', 'apple','Jennifer', 'gin', 'dog', 'blue', 'apple','Robert', 'gin', 'fish', 'blue', 'apple','Robert', 'whiskey', 'hamster', 'yellow', 'apple','Robert', 'tequila', 'fish', 'purple', 'apple','John', 'vodka', 'hamster', 'red', 'apple','Jennifer', 'tequila', 'dog', 'purple', 'apple','Robert', 'whiskey', 'dog', 'blue', 'apple','John', 'tequila', 'snake', 'blue', 'apple','Lilly', 'rum', 'cat', 'red', 'apple','Robert', 'gin' UNION ALL
    select 26, 1937, 'orange', 'Mike', 'whiskey', 'dog', 'yellow', 'orange', 'Mike', 'rum', 'dog', 'purple', 'orange', 'Jennifer', 'gin', 'snake', 'green', 'orange', 'Mike', 'gin', 'hamster', 'red', 'orange', 'John', 'gin', 'dog', 'green', 'orange', 'Lilly', 'whiskey', 'fish', 'purple', 'orange', 'Lilly', 'vodka', 'fish', 'red', 'orange', 'Lilly', 'vodka', 'dog', 'purple', 'orange', 'Jennifer', 'rum', 'hamster', 'green', 'orange', 'Robert', 'gin', 'snake', 'blue', 'orange', 'Mike', 'gin' UNION ALL
    select 27, 1021, 'banana','John', 'gin', 'cat', 'green', 'banana','John', 'vodka', 'snake', 'purple', 'banana','John', 'tequila', 'hamster', 'yellow', 'banana','Lilly', 'rum', 'cat', 'blue', 'banana','Lilly', 'gin', 'hamster', 'purple', 'banana','John', 'vodka', 'cat', 'red', 'banana','John', 'whiskey', 'hamster', 'green', 'banana','Robert', 'vodka', 'snake', 'blue', 'banana','John', 'whiskey', 'cat', 'red', 'banana','John', 'gin', 'dog', 'purple', 'banana','John', 'whiskey' UNION ALL
    select 28, 1919, 'apple','Lilly', 'gin', 'snake', 'blue', 'apple','Jennifer', 'rum', 'cat', 'blue', 'apple','John', 'whiskey', 'hamster', 'green', 'apple','Jennifer', 'whiskey', 'hamster', 'blue', 'apple','Jennifer', 'vodka', 'cat', 'yellow', 'apple','Lilly', 'vodka', 'snake', 'purple', 'apple','Mike', 'gin', 'fish', 'green', 'apple','Robert', 'tequila', 'dog', 'green', 'apple','Lilly', 'vodka', 'fish', 'blue', 'apple','Lilly', 'rum', 'hamster', 'red', 'apple','Mike', 'gin' UNION ALL
    select 29, 1642, 'orange', 'Mike', 'vodka', 'snake', 'yellow', 'orange', 'Lilly', 'whiskey', 'hamster', 'yellow', 'orange', 'Robert', 'vodka', 'fish', 'blue', 'orange', 'Lilly', 'gin', 'fish', 'red', 'orange', 'Jennifer', 'vodka', 'fish', 'red', 'orange', 'Jennifer', 'rum', 'snake', 'green', 'orange', 'John', 'vodka', 'fish', 'yellow', 'orange', 'Mike', 'rum', 'snake', 'red', 'orange', 'John', 'gin', 'cat', 'purple', 'orange', 'Mike', 'whiskey', 'cat', 'red', 'orange', 'Robert', 'whiskey' UNION ALL
    select 30, 1429, 'banana','Jennifer', 'whiskey', 'cat', 'yellow', 'banana','Jennifer', 'gin', 'snake', 'red', 'banana','Robert', 'gin', 'fish', 'yellow', 'banana','Jennifer', 'vodka', 'snake', 'purple', 'banana','Robert', 'rum', 'cat', 'yellow', 'banana','Jennifer', 'tequila', 'fish', 'purple', 'banana','Mike', 'gin', 'cat', 'red', 'banana','Robert', 'tequila', 'hamster', 'red', 'banana','Jennifer', 'gin', 'cat', 'yellow', 'banana','Lilly', 'vodka', 'fish', 'blue', 'banana','Mike', 'rum' UNION ALL
    select 31, 1067, 'apple','Lilly', 'whiskey', 'cat', 'purple', 'apple','Lilly', 'whiskey', 'cat', 'blue', 'apple','Robert', 'tequila', 'cat', 'red', 'apple','Lilly', 'tequila', 'cat', 'yellow', 'apple','John', 'vodka', 'dog', 'purple', 'apple','Robert', 'whiskey', 'dog', 'purple', 'apple','Lilly', 'vodka', 'dog', 'yellow', 'apple','Lilly', 'gin', 'fish', 'blue', 'apple','John', 'gin', 'fish', 'blue', 'apple','Jennifer', 'gin', 'dog', 'blue', 'apple','Mike', 'tequila' UNION ALL
    select 32, 1381, 'orange', 'John', 'gin', 'fish', 'blue', 'orange', 'Mike', 'tequila', 'hamster', 'yellow', 'orange', 'Jennifer', 'vodka', 'cat', 'purple', 'orange', 'Mike', 'gin', 'fish', 'green', 'orange', 'John', 'gin', 'cat', 'red', 'orange', 'Jennifer', 'whiskey', 'cat', 'purple', 'orange', 'Robert', 'whiskey', 'snake', 'blue', 'orange', 'Lilly', 'tequila', 'cat', 'purple', 'orange', 'Lilly', 'rum', 'fish', 'red', 'orange', 'Mike', 'gin', 'cat', 'purple', 'orange', 'Robert', 'tequila' UNION ALL
    select 33, 1423, 'banana','Jennifer', 'gin', 'cat', 'green', 'banana','Jennifer', 'vodka', 'snake', 'green', 'banana','Lilly', 'tequila', 'dog', 'green', 'banana','Mike', 'tequila', 'hamster', 'purple', 'banana','Lilly', 'whiskey', 'hamster', 'red', 'banana','Lilly', 'gin', 'snake', 'red', 'banana','Lilly', 'vodka', 'snake', 'blue', 'banana','Robert', 'gin', 'dog', 'red', 'banana','John', 'whiskey', 'snake', 'purple', 'banana','Robert', 'tequila', 'hamster', 'red', 'banana','Mike', 'tequila' UNION ALL
    select 34, 1854, 'apple','Mike', 'tequila', 'snake', 'blue', 'apple','Jennifer', 'tequila', 'fish', 'purple', 'apple','Mike', 'whiskey', 'cat', 'blue', 'apple','Robert', 'tequila', 'fish', 'yellow', 'apple','Jennifer', 'tequila', 'hamster', 'green', 'apple','Robert', 'whiskey', 'fish', 'red', 'apple','Lilly', 'gin', 'fish', 'green', 'apple','Lilly', 'gin', 'dog', 'purple', 'apple','Jennifer', 'gin', 'cat', 'red', 'apple','Mike', 'whiskey', 'cat', 'green', 'apple','Jennifer', 'tequila'
) as all_forms
    );;

  parameter: field_picker {
    type: string
    suggestions: ["all_forms.question_1,all_forms.question_2,all_forms.question_3,all_forms.question_4,all_forms.question_5,all_forms.question_6,all_forms.question_7,all_forms.question_8,all_forms.question_9,all_forms.question_10,all_forms.question_11,all_forms.question_12,all_forms.question_13,all_forms.question_14,all_forms.question_15,all_forms.question_16,all_forms.question_17,all_forms.question_18,all_forms.question_19,all_forms.question_20,all_forms.question_21,all_forms.question_22,all_forms.question_23,all_forms.question_24,all_forms.question_25,all_forms.question_26,all_forms.question_27,all_forms.question_28,all_forms.question_29,all_forms.question_30,all_forms.question_31,all_forms.question_32,all_forms.question_33,all_forms.question_34,all_forms.question_35,all_forms.question_36,all_forms.question_37,all_forms.question_38,all_forms.question_39,all_forms.question_40,all_forms.question_41,all_forms.question_42,all_forms.question_43,all_forms.question_44,all_forms.question_45,all_forms.question_46,all_forms.question_47,all_forms.question_48,all_forms.question_49,all_forms.question_50,all_forms.question_51,all_forms.question_52,all_forms.question_53"]
    default_value: "all_forms.question_1,all_forms.question_2,all_forms.question_3,all_forms.question_4,all_forms.question_5,all_forms.question_6,all_forms.question_7,all_forms.question_8,all_forms.question_9,all_forms.question_10,all_forms.question_11,all_forms.question_12,all_forms.question_13,all_forms.question_14,all_forms.question_15,all_forms.question_16,all_forms.question_17,all_forms.question_18,all_forms.question_19,all_forms.question_20,all_forms.question_21,all_forms.question_22,all_forms.question_23,all_forms.question_24,all_forms.question_25,all_forms.question_26,all_forms.question_27,all_forms.question_28,all_forms.question_29,all_forms.question_30,all_forms.question_31,all_forms.question_32,all_forms.question_33,all_forms.question_34,all_forms.question_35,all_forms.question_36,all_forms.question_37,all_forms.question_38,all_forms.question_39,all_forms.question_40,all_forms.question_41,all_forms.question_42,all_forms.question_43,all_forms.question_44,all_forms.question_45,all_forms.question_46,all_forms.question_47,all_forms.question_48,all_forms.question_49,all_forms.question_50,all_forms.question_51,all_forms.question_52,all_forms.question_53"
  }

  dimension: _passthrough {
    sql: {% parameter field_picker %};;
    hidden: yes
  }

  dimension: user_id {
    view_label: "Standard Fields"
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: form_id {
    view_label: "Standard Fields"
    type: string
    sql: ${TABLE}.form_id ;;
  }

  dimension: f1 {
    hidden: yes
    sql: ${TABLE}.f1 ;;
  }

  dimension: f2 {
    hidden: yes
    sql: ${TABLE}.f2 ;;
  }

  dimension: f3 {
    hidden: yes
    sql: ${TABLE}.f3 ;;
  }

  dimension: f4 {
    hidden: yes
    sql: ${TABLE}.f4 ;;
  }

  dimension: f5 {
    hidden: yes
    sql: ${TABLE}.f5 ;;
  }

  dimension: f6 {
    hidden: yes
    sql: ${TABLE}.f6 ;;
  }

  dimension: f7 {
    hidden: yes
    sql: ${TABLE}.f7 ;;
  }

  dimension: f8 {
    hidden: yes
    sql: ${TABLE}.f8 ;;
  }

  dimension: f9 {
    hidden: yes
    sql: ${TABLE}.f9 ;;
  }

  dimension: f10 {
    hidden: yes
    sql: ${TABLE}.f10 ;;
  }

  dimension: f11 {
    hidden: yes
    sql: ${TABLE}.f11 ;;
  }

  dimension: f12 {
    hidden: yes
    sql: ${TABLE}.f12 ;;
  }

  dimension: f13 {
    hidden: yes
    sql: ${TABLE}.f13 ;;
  }

  dimension: f14 {
    hidden: yes
    sql: ${TABLE}.f14 ;;
  }

  dimension: f15 {
    hidden: yes
    sql: ${TABLE}.f15 ;;
  }

  dimension: f16 {
    hidden: yes
    sql: ${TABLE}.f16 ;;
  }

  dimension: f17 {
    hidden: yes
    sql: ${TABLE}.f17 ;;
  }

  dimension: f18 {
    hidden: yes
    sql: ${TABLE}.f18 ;;
  }

  dimension: f19 {
    hidden: yes
    sql: ${TABLE}.f19 ;;
  }

  dimension: f20 {
    hidden: yes
    sql: ${TABLE}.f20 ;;
  }

  dimension: f21 {
    hidden: yes
    sql: ${TABLE}.f21 ;;
  }

  dimension: f22 {
    hidden: yes
    sql: ${TABLE}.f22 ;;
  }

  dimension: f23 {
    hidden: yes
    sql: ${TABLE}.f23 ;;
  }

  dimension: f24 {
    hidden: yes
    sql: ${TABLE}.f24 ;;
  }

  dimension: f25 {
    hidden: yes
    sql: ${TABLE}.f25 ;;
  }

  dimension: f26 {
    hidden: yes
    sql: ${TABLE}.f26 ;;
  }

  dimension: f27 {
    hidden: yes
    sql: ${TABLE}.f27 ;;
  }

  dimension: f28 {
    hidden: yes
    sql: ${TABLE}.f28 ;;
  }

  dimension: f29 {
    hidden: yes
    sql: ${TABLE}.f29 ;;
  }

  dimension: f30 {
    hidden: yes
    sql: ${TABLE}.f30 ;;
  }

  dimension: f31 {
    hidden: yes
    sql: ${TABLE}.f31 ;;
  }

  dimension: f32 {
    hidden: yes
    sql: ${TABLE}.f32 ;;
  }

  dimension: f33 {
    hidden: yes
    sql: ${TABLE}.f33 ;;
  }

  dimension: f34 {
    hidden: yes
    sql: ${TABLE}.f34 ;;
  }

  dimension: f35 {
    hidden: yes
    sql: ${TABLE}.f35 ;;
  }

  dimension: f36 {
    hidden: yes
    sql: ${TABLE}.f36 ;;
  }

  dimension: f37 {
    hidden: yes
    sql: ${TABLE}.f1 ;;
  }

  dimension: f38 {
    hidden: yes
    sql: ${TABLE}.f38 ;;
  }

  dimension: f39 {
    hidden: yes
    sql: ${TABLE}.f39 ;;
  }

  dimension: f40 {
    hidden: yes
    sql: ${TABLE}.f40 ;;
  }

  dimension: f41 {
    hidden: yes
    sql: ${TABLE}.f41 ;;
  }

  dimension: f42 {
    hidden: yes
    sql: ${TABLE}.f42 ;;
  }

  dimension: f43 {
    hidden: yes
    sql: ${TABLE}.f43 ;;
  }

  dimension: f44 {
    hidden: yes
    sql: ${TABLE}.f44 ;;
  }

  dimension: f45 {
    hidden: yes
    sql: ${TABLE}.f45 ;;
  }

  dimension: f46 {
    hidden: yes
    sql: ${TABLE}.f46 ;;
  }

  dimension: f47 {
    hidden: yes
    sql: ${TABLE}.f47 ;;
  }

  dimension: f48 {
    hidden: yes
    sql: ${TABLE}.f48 ;;
  }

  dimension: f49 {
    hidden: yes
    sql: ${TABLE}.f49 ;;
  }

  dimension: f50 {
    hidden: yes
    sql: ${TABLE}.f50 ;;
  }

  dimension: f51 {
    hidden: yes
    sql: ${TABLE}.f51 ;;
  }

  dimension: f52 {
    hidden: yes
    sql: ${TABLE}.f52 ;;
  }

  dimension: f53 {
    hidden: yes
    sql: ${TABLE}.f53 ;;
  }


}
