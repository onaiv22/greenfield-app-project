# WAF SQL INJECTION CONFIG
resource "aws_wafregional_sql_injection_match_set" "adroit_sql_injection_match_set" {
    name                  = "adroit_sql_injection_match_set"

    sql_injection_match_tuple {
      text_transformation = "URL_DECODE"

      field_to_match {
          type = "QUERY_STRING"
      }
    }

    sql_injection_match_tuple {
      text_transformation = "HTML_ENTITY_DECODE"

      field_to_match {
          type = "QUERY_STRING"
      }
    }

    sql_injection_match_tuple {
      text_transformation = "URL_DECODE"

      field_to_match {
          type = "BODY"
      }
    }

    sql_injection_match_tuple {
      text_transformation = "HTML_ENTITY_DECODE"

      field_to_match {
          type = "BODY"
      }
    }

    sql_injection_match_tuple {
      text_transformation = "URL_DECODE"

      field_to_match {
          type = "URI"
      }
    }

    sql_injection_match_tuple {
      text_transformation = "HTML_ENTITY_DECODE"

      field_to_match {
          type = "URI"
      }
    }
  
}

resource "aws_wafregional_rule" "sql_waf_rule" {
    depends_on  = [aws_wafregional_sql_injection_match_set.adroit_sql_injection_match_set]
    name        = "sqlinjection"
    metric_name = "sqlinjection"

    predicate {
        data_id = aws_wafregional_sql_injection_match_set.adroit_sql_injection_match_set.id
        negated = false
        type = "SqlInjectionMatch"
    }


}