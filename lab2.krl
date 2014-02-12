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
        select when pageview ".*" setting ()
        // Display notification that will not fade.
        every {
            notify("Hello World", "This is a sample rule.");
            notify("Hello World AGAIN", "This is a sample rule.");
        }
    }
    rule second_rule {
        select when pageview ".*" setting ()
        pre {
            q = page:url("query");
            name = (q.length() > 0) => q | "monkey";
            add5 = function(x) {
                x + 5
            };
            y = add5(5);
        }
       // notify(q, q.length() );
        
        
        notify("Hello " + name, y);

    }

}




