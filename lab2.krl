
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
        notify("Andy Notifying", "This is Andys notification") with sticky = true;
    }
}