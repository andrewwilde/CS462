ruleset a1299x176 {
    meta {
        name "lab2"
        author "Andrew Wilde"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
    rule first_rule {
        select when pageview ".*" setting ()
        notify("Andy", "Notifying you.") with sticky = true;
        notify("Second", "Notification") with sticky = true;
    }
}
