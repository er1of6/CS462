ruleset b505207x2 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
    }
    
    dispatch {
        // domain "exampley.com"
    }
    rule show_form {
        select when web pageview
        replace_inner("#main", "Random text paragraph....");
   }
}
