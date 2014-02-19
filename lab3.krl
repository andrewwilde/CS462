ruleset Lab3 {

  rule clear_rule {
    select when pageview re#\?clear=1#
    always {
      clear ent:lastname;
      clear ent:firstname;
      last
    }
  }

  rule show_form{
    select when pageview url re#.*#
    pre {
      my_div = << 
                  <div id="main"></div>
                >>;
      my_form = << 
                  <form id="my_form" onsubmit = "return false">
                  <input type="text" name="first"/>
                  <input type="text" name="last"/>
                  <input type="submit" value="Submit"/>
                  </form>
                >>;
      
    }
    
    if(not ent:firstname && not ent:lastname) then {
      watch("#my_form", "submit");
      //replace_inner("#main", "#my_form");
      //notify("My Div", my_div) with sticky = true;
    }

  }
  
  rule do_submit{
    select when web submit "#my_form"
    
    pre {
      firstname = event:attr("first");
      lastname = event:attr("last");
    }
    
    replace_inner("#main", "Hello #{firstname} #{lastname}");
    
    fired{
      set ent:firstname firstname;
      set ent:lastname lastname;
    }
  }

}
