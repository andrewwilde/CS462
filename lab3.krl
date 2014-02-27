ruleset Lab3 {

  global {
  }

  rule add_div {
    select when pageview url re#.*#
    pre {
      my_div = << 
                  <div id="andy_div"></div>
                  <div id="name_id"></div>
                >>;
    }
    
    replace_inner("#main", my_div);
  }

  rule show_form{
    select when pageview url re#.*#
    pre {

      a_form = << 
                  <form id="my_form" onsubmit="return false">
                  Movie: <input type="text" name="first"/>
                  <input type="submit" value="Submit"/>
                  </form>
                >>;
      
    }
    every{
      replace_inner("#andy_div", a_form);
      watch("#my_form", "submit");
    }
  }

  rule do_submit{
      select when web submit "#my_form"
      
      pre {
        name = event:attr("first");
        url = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=xhkss6kr29cnqzt87b4hmyvv&q=" + name;
        r = http:get(url).pick("$.total").decode();;
      }
      
      replace_inner("#name_id", r)
  }

}
