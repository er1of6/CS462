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
       
       getMovie = funtion(searchTerm){
         r = http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
               {"apikey": "xnrrv5u46fcruqw642tm7v2z",
               "q": "starwars"
               }
              );
              
        r
        }
              
        
       }
       
       append("#main", getMovie("thing");
       
       
    }
    rule second_rule {
        select when web pageview
        pre {
           
        }
        
    }
}

