({
    createTransaction: function(component, transaction) {
        var action = component.get("c.saveTransaction");
        action.setParams({
            "transaction": transaction
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var transactions = component.get("v.transactions");
				System.debug("Failed with state: " + state);
                transactions.push(response.getReturnValue());
                component.set("v.transactions", transactions);
            }
            else{
				System.debug("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})