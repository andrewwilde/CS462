ruleset Lab3 {

  rule show_form{
    select when pageview url re#.*#
    pre {
      my_div = << 
                  <div id="main"></div>
                >>;
    }
    
    notify("Lab 3 Stuff", my_div) with sticky = true;
    
  }

}
