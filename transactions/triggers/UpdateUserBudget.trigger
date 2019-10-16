trigger UpdateUserBudget on Transaction__c (after insert, before update, after update) {
    List<User> users = [SELECT id, Name, Budget__c FROM User];    
    if (Trigger.isAfter) {
       if (Trigger.isInsert || Trigger.isUpdate ) {
        	for (Transaction__c t : Trigger.New) {
                for (User u : users) {
                    if (u.Id == t.OwnerId) {
                    	u.Budget__c = u.Budget__c + t.Amount__c;                
                		update u;    
                    }                              	
                }                
        	}
   		}
    } else {
    	for (Transaction__c t : Trigger.Old) {
            for(User u : users) {
                if (u.Id == t.OwnerId) {                
                	u.Budget__c = u.Budget__c - t.Amount__c;                
                	update u;    
                }
            }                    
        }
    }  
}