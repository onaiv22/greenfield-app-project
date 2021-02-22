resource "aws_wafregional_size_constraint_set" "adroit_largebody" {
  name = "largebodyset"

  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "GT"
    size                = "8192"

    field_to_match {
      type = "BODY"
    }
  }
  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "LE"
    size                = "40"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }
  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "LE"
    size                = "4096"

    field_to_match {
      type = "QUERY_STRING"
    }
  }
  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "LE"
    size                = "4096"

    field_to_match {
      type = "URIPATH"
    }
  }
  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "LE"
    size                = "4096"

    field_to_match {
      type = "URIPATH"
    }
  }
  #Max Parammeter Name Length - specifies the maximum length of any parameter name
  size_constraints {            
    text_transformation = "NONE"
    comparison_operator = "LE"
    size                = "64"

    field_to_match {
      type = "ALLQUERYARGUMENTS"
    }
  }
}

#still to do
/* maximum upload files 
max parameters - the max number of form parameters allowed in a GET query string 
and/or in the request body containing form parameters and values */

resource "aws_wafregional_rule" "adroit_largebodyrule" {
  name        = "largebodyrule"
  metric_name = "largebodyrule"

  predicate {
    data_id = aws_wafregional_size_constraint_set.adroit_largebody.id
    negated = false
    type    = "SizeConstraint"
  }
}