ruleset Lab3 {

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
    
    notify("Lab 3 Stuff", my_form) with sticky = true;
    
  }

}
