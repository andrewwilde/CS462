ruleset rotten_tomatoes{

  global {
    r = http:get("http://http://api.rottentomatoes.com/api/public/v1.0/movies.json",
               {"apikey": "xhkss6kr29cnqzt87b4hmyvv"
               }
              );
    
  }
  
  rule obtain_rating {
    select when pageview re#\imdb.com#
    
    pre{
      movie = page:env("title");
    }
  }
}
