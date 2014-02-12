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
        notify("Hello World", "This is a sample rule.") with sticky = true;
        
        select when pageview ".*" setting ()
        notify("Hello World AGAIN", "This is a sample rule.") with position = "top-left";
    }

}
