ruleset Lab2 {

    meta {
        name "lab2"
        author "Andrew Wilde"
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
        pre {
            x = page:url("query");
        }
        if(x == ""){
            notify("Hello", "Monkey") with sticky = true;
        }
        else {
            notify("Hello", x) with sticky = true;
        }
    }
}
