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
    }
    rule first_rule {
        select when web pageview
       
       pre{
       
            getMovie = function(searchTerm){
                r = http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
                    {"apikey": "xnrrv5u46fcruqw642tm7v2z",
                    "q": "starwars"});
              
              //  r.pick("$.content").decode().values().tail().as("str");
              
                movie = r.pick("$.content").decode().pick("$.movies[0]");
                thumbnail = movie.pick("$..thumbnail");
                title = movie.pick("$..title");
                year = movie.pick("$..year");
                synopsis  = movie.pick("$..synopsis");
                critics_score  = movie.pick("$..critics_score");
                critics_rating = movie.pick("$..critics_rating");
                audience_rating = movie.pick("$..audience_rating");
                audience_score = movie.pick("$..audience_score");
                
                html = "<h2> " + title + "</h2>";
                html += year;
                html
            };
        }
       
       replace_inner("#main", "<div>" + getMovie("thing") + "</div>");
       
    }
    rule second_rule {
        select when web pageview
        pre {
           
        }
        
    }
}

