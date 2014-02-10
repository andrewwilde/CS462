ruleset Lab2 {

    meta {
        name "lab2"
        author "Andrew Wilde"
    }
    pre{
        x = page:url("query");
    }
    rule first_rule {
        select when pageview ".*"
        every{
            notify("Andy", "Notifying you") with sticky = true;
            notify("Second", "Notification") with sticky = true;
        }
    }
    
    rule second_rule {
        select when pageview ".*"
        notify("Hello", x) with sticky = true;
    }
}
