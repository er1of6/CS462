ruleset b505207x2 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
    }
    
    dispatch {
        // domain "exampley.com"
    }
   show_form {
    replace_inner("#main", "Random text paragraph....");
   }
}
