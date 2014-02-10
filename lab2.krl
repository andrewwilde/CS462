
ruleset Lab2 {
    meta {
        name "lab2"
        author "Andrew Wilde"
    }
    rule first_rule {
        notify("Hello World", "This is a sample rule.") with sticky = true;
    }
}