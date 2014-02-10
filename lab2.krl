
ruleset a1299x176 {
    meta {
        name "lab2"
        author "Andrew Wilde"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
    rule andy_notify {
        select when pageview ".*" setting ()
        notify("This is my notification!") with sticky = true;
    }
}