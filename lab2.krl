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
    rule second_rule{
    
        query = page:url("query");
        if(query){
            notify("Hello" + query, "");
        }else{
            notify("Hello Monkey", "");
        }
    }

}
