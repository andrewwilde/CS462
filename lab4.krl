ruleset rotten_tomatoes{

  global {
    r = http:get("http://http://api.rottentomatoes.com/api/public/v1.0/movies.json",
                {"apikey": "xhkss6kr29cnqzt87b4hmyvv"}
                );
    
  }
  
  rule set_structure {
    select when pageview url re#.*#
    
    pre{
     my_div = << 
                  <div id="movie_id"></div>
                  <div id="form_id"></div>
                >>;
    }
    replace_inner("#main", my_div);
  }
  
  rule show_form{
    select when pageview url re#.*#
    pre {
      a_form = << 
                  <form id="my_form" onsubmit="return false">
                  <input type="text" name="movie"/>
                  <input type="submit" value="Submit"/>
                  </form>
                >>;
    }
    every{
      replace_inner("#form_id", a_form);
      watch("#my_form", "submit");
    }
  }
}
