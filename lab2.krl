
ruleset Lab2 {
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
        // Display notification that will not fade.
        notify("Andy Wilde", "Notifying You!") with sticky = true;
    }
}