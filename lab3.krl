ruleset Lab3 {

  rule add_div {
    select when pageview url re#.*#
    pre {
      my_div = << 
                  <div id="main">This is the div</div>
                >>;
    }
    notify ("Lab 3", my_div) with sticky = true;
  }

  rule clear_rule {
    select when pageview re#\?clear=1#
    
    notify("Clearing Name", "");
    
    always {
      clear ent:lastname;
      clear ent:firstname;
      last;
    }
  }

  rule show_form{
    select when pageview url re#.*#
    pre {

      a_form = << 
                  <form id="my_form" onsubmit="return false">
                  <input type="text" name="first"/>
                  <input type="text" name="last"/>
                  <input type="submit" value="Submit"/>
                  </form>
                >>;
      
    }
    every{
      replace_inner("#main", a_form);
      watch("#my_form", "submit");
    }
  }
  
    rule show_name{
    select when pageview url re#.*#
    pre {
      
    }
    
    notify("Welcome", "People") with sticky = true;
  }


  rule do_submit{
      select when web submit "#my_form"
      
      pre {
        firstname = event:attr("first");
        lastname = event:attr("last");
      }
      replace_inner("#main", firstname);
      
      fired{
        set ent:firstname firstname;
        set ent:lastname lastname;
      }
    }

}
