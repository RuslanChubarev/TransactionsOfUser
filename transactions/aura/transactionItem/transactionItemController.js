({
    doInit : function(component, event, helper) {
        var mydate = component.get("v.transaction.Date__c");
        if(mydate){
            component.set("v.formatdate", new Date(mydate));
        }
    },
    
    handleClick : function(component, event, helper) {
		console.log('Create record');
        
        //getting the transaction information
        var mainTransaction = component.get("v.transaction");
        
        
        //Calling the Apex Function
        var action = component.get("c.deleteTransaction");
        
        //Setting the Apex Parameter
        action.setParams({
            "myTransaction" : mainTransaction
        });
        
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            
            //check if result is successfull
            if(state == "SUCCESS"){
                component.find('notif').showNotice({
            	"variant": "info",
            	"header": "Success!",
            	"message": "Record successfully deleted .",
                closeCallback: function() {
					$A.get('e.force:refreshView').fire();            	
                }
       			});
            } else if(state == "ERROR"){
                alert('Error in calling server side action');
            }
        });
        
		//adds the server-side action to the queue        
        $A.enqueueAction(action);
    },
    
	editRecord : function(component, event, helper) {
    var editRecordEvent = $A.get("e.force:editRecord");
        
    editRecordEvent.setParams({
         "recordId": component.get("v.transaction.Id")
   	});
    editRecordEvent.fire();
    },
	
  
})