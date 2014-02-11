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
            x = page:url("query") || "Monkey";
            getName = function(page){
                        page.extract(#name=(\w)*#) || "Monkey";
                        };
            pages = ent:archive_pages;
            y = getName(x)
        }
        notify("Hello", y) with sticky = true;
    }
}
