
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
        // Display notification that will not fade.
        notify("Hello World", "This is a sample rule.") with sticky = true;
    }
}