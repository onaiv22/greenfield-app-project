resource "aws_waf_byte_match_set" "allowed_methods" {
    name = "allowed_methods_contents"

    byte_match_tuples {
      text_transformation   = "NONE"
      target_string         = "GET"
      positional_constraint = "EXACTLY"

      field_to_match {
          type = "METHOD"
      }  
    }
    byte_match_tuples {
      text_transformation   = "NONE"
      target_string         = "DELETE"
      positional_constraint = "EXACTLY"

      field_to_match {
          type = "METHOD"
      }  
    }
    byte_match_tuples {
      text_transformation   = "NONE"
      target_string         = "HEAD"
      positional_constraint = "EXACTLY"

      field_to_match {
          type = "METHOD"
      }  
    }
    byte_match_tuples {
      text_transformation   = "NONE"
      target_string         = "POST"
      positional_constraint = "EXACTLY"

      field_to_match {
          type = "METHOD"
      }  
    }
    byte_match_tuples {
      text_transformation   = "NONE"
      target_string         = "PUT"
      positional_constraint = "EXACTLY"

      field_to_match {
          type = "METHOD"
      }  
    }
    byte_match_tuples {
      text_transformation   = "NONE"
      target_string         = "application/json"
      positional_constraint = "CONTAINS"

      field_to_match {
          type = "BODY"
      }  
    }
    byte_match_tuples {
      text_transformation   = "NONE"
      target_string         = "application/x-www-form-urlencoded"
      positional_constraint = "CONTAINS"

      field_to_match {
          type = "BODY"
      }  
    }
    byte_match_tuples {
      text_transformation   = "NONE"
      target_string         = "multipart/form-data"
      positional_constraint = "CONTAINS"

      field_to_match {
          type = "BODY"
      }  
    }
    byte_match_tuples {
      text_transformation   = "NONE"
      target_string         = "txet/xml"
      positional_constraint = "CONTAINS"

      field_to_match {
          type = "BODY"
      }  
    }
}