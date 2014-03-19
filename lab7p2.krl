ruleset b505207x8 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    
  rule show_fs_location is active {
        select when web cloudAppSelected
        
        pre{
             my_html = <<
            <h5>Hello, world!</h5>
            event: #{ent:name} </br>
            dr: #{ent:dr} </br>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
        }
  }  
  
  rule nearby is active {
    select when explicit nearby
    
    pre{
       
    }
    always{
    set ent:name "nearby";
    set ent:dr event:attr("dr");
    }
  
  }
  
  rule faraway is active {
    select when explicit faraway
    
      pre{
     //   dr = event:attr("dr");
    }
     always{
    set ent:name "faraway";
    set ent:dr event:attr("dr");
    }
    
  }
  
   
  
}
