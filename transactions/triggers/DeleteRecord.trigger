trigger DeleteRecord on Transaction__c (after delete) {    
    List<User> users = [SELECT id, Name, Budget__c FROM User];    
	for (Transaction__c t : Trigger.Old) {
        for (User u : users) {
        	if(t.OwnerId == u.Id) {
                u.Budget__c = u.Budget__c - t.Amount__c;
        		update u;
                break;
            }    
        }       	
    }    
}