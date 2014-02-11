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
            getClear = function(page){
                        page.match(re#clear#) => true
                                                    | false
                        };
                        
            y = getName(x);
        }
        if ent:count < 5 then
            notify("Hello", y) with sticky = true;
       
    }
    
    rule third_rule {
        select when pageview ".*"
        pre {
            x = ent:views;
            page = page:url("query") || "Monkey";
            getName = function(page){
                        y = page.extract(#name=(\w*)#);
                        page.match(re#name=#) => y[0] 
                                                    | "Monkey";
                        };
        }
        
        if x <= 5 then
            notify("Count: ", x) with sticky = true;
        fired{
            ent:views += 1 from 1;
        }
        else {
            clear ent:views;
            }
        
    }
}
