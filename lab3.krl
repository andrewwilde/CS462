ruleset Lab3 {

  rule clear_rule {
    select when pageview re#\?clear=1#
    
    notify("Clearing Name", "");
    
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
    
    if(not ent:lastname && not ent:firstname) then
      notify("Hello", my_form) with sticky = true;
    fired{
      last
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
    
    fired{
      set ent:firstname firstname;
      set ent:lastname lastname;
    }
  }
}
