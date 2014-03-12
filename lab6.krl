ruleset b505207x5 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }

  rule add_location_item{
    select when explicit new_location_data
    
    pre{
        key = event:attr("key");
        value = event:attr("value");
    }
    
    always{
        replace_inner("#main", "Hello");
        notify(key.as("str"), value.as("str")) with sticky = true;
    }
    
    }
  
}
