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
        
        pre{
            watch_link = <<
            <div>
                <form>
                    First name: <input type="text" name="firstname"><br>
                    Last name: <input type="text" name="lastname">
                    <input type="submit" value="Submit">
                </form>
            </div>
            >>;
        }
        {
            append('body', watch_link);
            watch("#watched", "click");
        }
        replace_inner("#main", "Random text paragraph....");
   }
}
