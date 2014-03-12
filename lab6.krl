ruleset b505207x5 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    
  rule HelloWorld is active {
        select when web cloudAppSelected
        pre {
            my_html = <<
            <h5>Hello, world!</h5>
            Value: #{ent:v} </br>
            Key: #{ent:k} </br>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
       
            notify("message1", " ") with sticky = true;
        }
  }   
    

  rule add_location_item{
    select when explicit new_location_data
    
    pre{
        key = event:attr("key");
        value = event:attr("value");
    }
    
    always{
        set ent:k key;
        set ent:v value;
    }
    
    }
}

//     CloudRain:createLoadPanel("Hello World!", {}, my_html);
