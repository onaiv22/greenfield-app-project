resource "aws_waf_byte_match_set" "byte_set" {
  name = "file_extensions"

  byte_match_tuples {
    text_transformation   = "NONE"
    target_string         = ".bmp"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "content-type"
    }
  }
  byte_match_tuples {
    text_transformation   = "NONE"
    target_string         = ".jpeg"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "content-type"
    }
  }
  byte_match_tuples {
    text_transformation   = "NONE"
    target_string         = ".pdf"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "content-type"
    }
  }
  byte_match_tuples {
    text_transformation   = "NONE"
    target_string         = ".rar"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "content-type"
    }
  }
  byte_match_tuples {
    text_transformation   = "NONE"
    target_string         = ".xls"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "content-type"
    }
  }
  byte_match_tuples {
    text_transformation   = "NONE"
    target_string         = ".xlsx"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "content-type"
    }
  }
  byte_match_tuples {
    text_transformation   = "NONE"
    target_string         = ".xml"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "content-type"
    }
  }
  byte_match_tuples {
    text_transformation   = "NONE"
    target_string         = ".zip"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "content-type"
    }
  }
}