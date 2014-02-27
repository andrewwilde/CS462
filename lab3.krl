ruleset Lab3 {

  global {
  }

  rule add_div {
    select when pageview url re#.*#
    pre {
      my_div = << 
                  <div id="name_id"></div>
                  <div id="andy_div"></div>
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
        r = http:get(url).pick("$.content").decode();
        total = r.pick("$.total");
        thumbnail = r.pick("$.movies[0].posters.thumbnail");
        title = r.pick("$.movies[0].title");
        year = r.pick("$.movies[0].year");
        synopsis = r.pick("$.movies[0].synopsis");
        critic_rating = r.pick("$.movies[0].ratings.critics_rating");
        runtime = r.pick("$.movies[0].runtime");
        consensus = r.pick("$.movies[0].critics_consensus");
        
        movie_div = << <table bordoer = 0>
                        <tr><td><img src="#{thumbnail}"></td>
                              <td><h3>#{title}</h3></td></tr>
                        <tr><td>Year: </td><td>#{year}</td></tr>
                        <tr><td>Synopsis: </td><td>#{synopsis}</td></tr>
                        <tr><td>Critic Rating: </td><td>#{critic_rating}</td></tr>
                        <tr><td>Runtime: </td><td>#{runtime}</td></tr>
                        <tr><td>Critics Consensus: </td><td>#{consensus}</td></tr>
                        </table> >>;
                        
        message = "No Movie Found";
      
        blast = function(tot){
                (tot > 0) => movie_div | message
              }
        
        real_message = blast(total);
      }
      

      
      replace_inner("#name_id", real_message);

  }
  
}
