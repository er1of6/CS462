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
              
                r.pick("$.content").decode().pick("$.movies").as("str");
                
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

