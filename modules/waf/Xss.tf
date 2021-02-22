#Waf Cross Site Scripting
resource "aws_wafregional_xss_match_set" "adroit_xss_match_set" {
    name = "adroit_xss_match_set"

    xss_match_tuple {
      text_transformation = "URL_DECODE"

      field_to_match {
          type = "QUERY_STRING"
      }
    }

    xss_match_tuple {
      text_transformation = "HTML_ENTITY_DECODE"

      field_to_match {
          type = "QUERY_STRING"
      }
    }

    xss_match_tuple {
      text_transformation = "HTML_ENTITY_DECODE"

      field_to_match {
          type = "BODY"
      }
    }

    xss_match_tuple {
      text_transformation = "URL_DECODE"

      field_to_match {
          type = "BODY"
      }
    }

    xss_match_tuple {
      text_transformation = "URL_DECODE"

      field_to_match {
          type = "URI"
      }
    }

    xss_match_tuple {
      text_transformation = "HTML_ENTITY_DECODE"

      field_to_match {
          type = "URI"
      }
    }
}

resource "aws_wafregional_rule" "adroit_xss_waf_rule" {
    depends_on = [aws_wafregional_xss_match_set.adroit_xss_match_set]
    name       = "adroitXSS"
    metric_name = "adroitXSS"
    
    predicate {
      data_id   = aws_wafregional_xss_match_set.adroit_xss_match_set.id
      negated   = false
      type      = "XssMatch"
    }
    
}

/* to do 
xss_match_tuple {
      text_transformation = "HTML_ENTITY_DECODE" and another block for URL_DECODE

      field_to_match {
          type = "HEADER"
          data = "cookie"
      }
    } */