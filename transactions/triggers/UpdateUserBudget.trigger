trigger UpdateUserBudget on Transaction__c (after insert, before update, after update, after delete) {
    id userId =  UserInfo.getUserId();
    User u = [select Id, Name, Budget__c from User WHERE id=:userId Limit 1];   
    if (Trigger.isAfter) {
       if (Trigger.isInsert || Trigger.isUpdate) {
        	for (Transaction__c t : Trigger.New) {               
            	if (u.Id == t.OwnerId) {
                   	u.Budget__c = u.Budget__c + t.Amount__c;                   
                }                              	                
        	}
           	update u;
   		}
        else {
            for (Transaction__c t : Trigger.Old) {        		
        		if(t.OwnerId == u.Id) {
                	u.Budget__c = u.Budget__c - t.Amount__c;
            	}         	
    		}
            update u;
    	}
    } else {
    	for (Transaction__c t : Trigger.Old) {
        	if (u.Id == t.OwnerId) {                
                u.Budget__c = u.Budget__c - t.Amount__c;                  
             }                   
        }
        update u;
    }  
}