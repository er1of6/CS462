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
            <div id="test">
                <form>
                    First name: <input type="text" name="firstname"><br>
                    Last name: <input type="text" name="lastname">
                    <input id = "watched" type="submit" value="Submit">
                </form>
            </div>
            >>;
        }
        {
         //   append('body', watch_link);
         replace_inner("#main", watch_link);
            watch("#watched", "click");
        }
        
   }
   
    rule clicked_rule {
        select when web click "#watched"
        notify("You clicked", 'Watch');
    }
}
