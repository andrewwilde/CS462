ruleset Lab2 {

    meta {
        name "lab2"
        author "Andrew Wilde"
    }
    rule first_rule {
        select when pageview ".*"
        every{
            notify("Andy Notifying you", "") with sticky = true;
            notify("Andy's Second Notification", "") with sticky = true;
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
            notify("Hello " + y, "") with sticky = true;
       
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
            notify("Count: " + x, "") with sticky = true;
        fired{
            ent:views += 1 from 1;
        }
        
    }
    
    rule clear_rule {
        select when pageview ".*"
        pre{
            page = page:url("query");
            getClear = function(p){
                            p.match(re#clear=1#) => true 
                                                    | false;
                            };
            c = getClear(page);
        }
        if c then
            notify("Count Cleared", "") with sticky = true;
        fired{
            clear ent:views;
            }
    }
}
