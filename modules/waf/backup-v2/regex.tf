resource "aws_wafv2_regex_pattern_set" "adroit_regex" {
    name = "adroit_regex"
    description = "regex pattern set"
    scope = "REGIONAL" 

    regular_expression {
        regex_string = "one"
    }

    regular_expression {
      regex_string = "two"
    }

    regular_expression {
      regex_string = "B[a@]dB[o0]t"
    }

    tags = {
      "Name" = "adroit_regex"
    }
}