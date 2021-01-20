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
}

resource "aws_wafregional_rule" "adroit_largebodyrule" {
  name        = "largebodyrule"
  metric_name = "largebodyrule"

  predicate {
    data_id = aws_wafregional_size_constraint_set.adroit_largebody.id
    negated = false
    type    = "SizeConstraint"
  }
}