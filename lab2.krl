
ruleset Lab2 {
    meta {
        name "lab2"
        author "Andrew Wilde"
    }
    rule first_rule {
        select when pageview ".*" setting ()
        notify("Andy Wilde", "Notifying You") with sticky = true;
    }
}