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
                    <input type="submit" value="Submit">
                </form>
            </div>
            >>;
        }
        {
         //   append('body', watch_link);
         replace_inner("#test", watch_link);
            watch("#test", "click");
        }
        
   }
}
