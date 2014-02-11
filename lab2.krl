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
                        y = page.extract(#name=(\w*)#);
                        page.match(re#name=#) => y[0] 
                                                    | "Monkey";
                        };
            y = getName(x);
            z = ent:count;
        }
        if ent:count > 5 within 3 days then
            notify("Hello", y + ", Count: " + z) with sticky = true;
        fired {
            ent:count +=1 from 1;
        }
        else {
            clear ent:count;
            }
    }
}
