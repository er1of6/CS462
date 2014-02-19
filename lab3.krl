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
                    <input id = "watched" type="submit" value="Submit">
                </form>
            </div>
            >>;
        }
        {
           append('main', watch_link);
        // replace_inner("#main", watch_link);
            watch("#watched", "click");
        }
        
   }
   
    rule clicked_rule {
        select when web click "#watched"
        notify("You clicked", 'Watch');
    }

    rule clear_stuff{
        select when web pageview
        pre {
            q = page:url("query");
            clearFireCount = function(x) {
                pairs = x.split(re/&/);
                lists = pairs.collect(function(a){a.match(re/clear=1/) => "clearPairs" | "otherPairs"});
                result = (lists{"clearPairs"}.length() > 0) => true | false;
                result
            };
            answer = clearFireCount(q); 
        }   

        notify("RESULT", answer);
        if answer then{
            noop();
        }
        fired{
            clear ent:firstName;
            clear ent:lastName;
        }
        
    }
}
