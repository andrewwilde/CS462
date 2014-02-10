
ruleset Lab2 {
    meta {
        name "lab2"
        author "Andrew Wilde"
    }
    rule first_rule {
        notify("Andy", "This is a sample rule.") with sticky = true;
    }
}