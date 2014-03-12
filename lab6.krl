ruleset b505207x5 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    
    rule rule{
        select when web pageview
        
        pre {
            my_html = <<
            <h5>Hello, world!</h5>
            Venue: #{ent:k} </br>
            City: #{ent:v} </br>
            shout: #{ent:shout} </br>
            >>;
        }
        
        notify(ent:k, ent:v) with sticky = true
    }    
    

  rule add_location_item{
    select when explicit new_location_data
    
    pre{
        key = event:attr("key");
        value = event:attr("value");
    }
    
    every{
    
        set:ent k key;
        set:ent v value;
    }
    
    }
}
