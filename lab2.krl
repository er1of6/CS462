ruleset b505207x1 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
    }
    
    dispatch {
        // domain "exampley.com"
    }
    rule first_rule {
        select when web pageview
        // Display notification that will not fade.
        every {
            notify("Hello World", "This is a sample rule.");
            notify("Hello World AGAIN", "This is a sample rule.");
        }
    }
    rule second_rule {
        select when web pageview
        pre {
            q = page:url("query");
            findName = function(x) {
                pairs = x.split(re/&/);
                //pairs[1]
                lists = pairs.collect(function(a){a.match(re/name/) => "namePairs" | "otherPairs"});
                lists["namePairs"]
                //namePairs.length()
                //lists.length()
               // pairs.collect(function(a){(a.match(re/name/))})
                
               // name = (x.length() > 0) => x | "monkey";
                //name
            };
        }
       // notify(q, q.length() );
        
        
        notify("Hello " + findName(q), " ");

    }

}







