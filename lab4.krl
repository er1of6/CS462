ruleset b505207x3 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
    }
    
    dispatch {
        // domain "exampley.com"
        // xnrrv5u46fcruqw642tm7v2z
    }
    global {
        baseUrl = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?";
         watch_link = <<
                <form id = "my_form" onsubmit="return false" >
                    Title: <input type="text" name="inputTitle"><br>
                    <input type="submit" value="Submit">
                </form>
            >>;
              getMovie = function(searchTerm){
                r = http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
                    {"apikey": "xnrrv5u46fcruqw642tm7v2z",
                    "q": "#{searchTerm}"});
              
                movie = r.pick("$.content").decode().pick("$.movies[0]");
                thumbnail = movie.pick("$..thumbnail");
                title = movie.pick("$..title");
                year = movie.pick("$..year");
                synopsis  = movie.pick("$..synopsis");
                critics score  = movie.pick("$..critics_score");
                critics rating = movie.pick("$..critics_rating");
                audience rating = movie.pick("$..audience_rating");
                audience score = movie.pick("$..audience_score");

                html = << 
                <h2> #{title} </h2>
                <img src="#{thumbnail}" width="100">  </br>
                    year:#{year} </br>
                    synopsis: #{synopsis} </br>
                    critics_score: #{critics_score} </br>
                    critics_rating: #{critics_rating} </br>
                    audience_rating: #{audience_rating} </br>
                    audience_score: #{audience_score} </br>

                >>;
                
                html
            };
    }
    rule first_rule {
        select when web pageview
       
       pre{
       
        }
        
        every{
        
        append("#main", watch_link);
        
        watch("#my_form", "submit");
        }
        
     
       
    }
      rule clicked_rule {
        select when web submit "#my_form"
        pre{
            searchTitle = event:attr("inputTitle")
            
        }
        
          every{
       
        replace_inner("#main", getMovie(searchTitle) );
        append("#main", watch_link);
        
        watch("#my_form", "submit");
        }
       
    }
}

