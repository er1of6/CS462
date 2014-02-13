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
        select when web pageview
        // Display notification that will not fade.
        every {
            notify("Hello World", "This is a sample rule.");
            notify("Hello World AGAIN", "This is a sample rule.");
        }
    }
    rule second_rule {
        select when web pageview
        pre {
            q = page:url("query");
            findName = function(x) {
                pairs = x.split(re/&/);
                lists = pairs.collect(function(a){a.match(re/name/) => "namePairs" | "otherPairs"});
                name = (lists{"namePairs"}.length() > 0) => lists{"namePairs"}.head().substr(5) | "monkey";
                name
            };
        }
        
        notify("Hello " + findName(q), " ");
    }

    rule rule_fired_count {
        select when web pageview
        pre{
            c = ent:fire_count;
        }
        if ent:fire_count < 5 then
            notify("COUNT", ent:fire_count)
        fired{
            ent:fire_count +=1 from 1;
        } 
    }

    rule clear_count{
        select when web pageview
        pre {
            q = page:url("query");
            clearFireCount = function(x) {
                pairs = x.split(re/&/);
                lists = pairs.collect(function(a){a.match(re/clear=/) => "clearPairs" | "otherPairs"});
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
            set ent:fire_count 0;
        }
        
    }
}
