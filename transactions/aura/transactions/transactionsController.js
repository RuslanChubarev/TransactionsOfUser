({
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getTransactions");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.transactions", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
	clickCreate : function(component, event, helper) {
		console.log('Create record');
        
        //getting the transaction information
        var mainTransaction = component.get("v.newTransaction");
        
        
        //Calling the Apex Function
        var action = component.get("c.saveTransaction");
        
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
                $A.get('e.force:refreshView').fire();
                //Reset Form
                var newTransaction = { 'sobjectType': 'Transaction__c',
                        'Name': '',
                        'Amount__c': 0,
                        'Date__c': ''};
                //resetting the Values in the form
                component.set("v.newTransaction",newTransaction);
                alert('Record is Created Successfully');
            } else if(state == "ERROR"){
                alert('Error in calling server side action');
            }
        });
        
		//adds the server-side action to the queue        
        $A.enqueueAction(action);
    },
    
    handleToastEvent : function(component, event, helper) {
    var toastMessageParams = event.getParams();
    var message = toastMessageParams.message;

    if (message.includes('Transaction') && message.includes('was saved')) {
                $A.get('e.force:refreshView').fire();
    	}
	}
})