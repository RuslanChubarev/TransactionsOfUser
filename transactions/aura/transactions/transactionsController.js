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
        
        //get name of transaction
		var inputName = component.find("transactionname");
        var valueOfName = inputName.get("v.value");
		
        //get amount of transaction
        var inputAmount = component.find("transactionamount");
        var valueOfAmount = inputAmount.get("v.value");
        
		//get date of transaction
        var inputDate = component.find("transactiondate");
        var valueOfDate = inputDate.get("v.value");
        
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
            if(state == "SUCCESS" && valueOfName != '' && valueOfAmount != 0 && valueOfDate != null){
                //Reset Form
                var newTransaction = { 'sobjectType': 'Transaction__c',
                        'Name': '',
                        'Amount__c': 0,
                        'Date__c': ''};
                //resetting the Values in the form
                component.set("v.newTransaction",newTransaction);
                component.find('successNotif').showNotice({
            	"variant": "info",
            	"header": "Success!",
            	"message": "Record successfully added .",
                closeCallback: function() {
					$A.get('e.force:refreshView').fire();            	}
       			 });                 
            } else if(state == "ERROR" || valueOfName == '' || valueOfAmount == 0 || valueOfDate == null){
                component.find('successNotif').showNotice({
            	"variant": "error",
            	"header": "Error!",
            	"message": "Please, enter data in fields.",
                closeCallback: function() {
					$A.get('e.force:refreshView').fire();            	}
       			 });
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