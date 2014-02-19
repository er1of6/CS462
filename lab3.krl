ruleset b505207x2 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
    }
    
    dispatch {
        // domain "exampley.com"
    }
    
    rule init {
        select when web pageview
        
        pre{
            watch_link = <<
                <form id = "my_form" onsubmit="return false" >
                    First name: <input type="text" name="firstname"><br>
                    Last name: <input type="text" name="lastname">
                    <input type="submit" value="Submit">
                </form>
            >>;
        }
        if(not ent:username) then{
            append("#main",watch_link);
            watch("#my_form", "submit");
        }
        fired{ 
            last;
        }
    }
     
    rule clicked_rule {
        select when web submit "#my_form"
        pre{
            username = event:attrb("firstname") + " " + event:attrb("lastname");
        }
        replace_inner("#main", "Hello #{username}");
        fired{
            set:ent:username username;
        }
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
            clear ent:userName;
        }
        
    }
}
