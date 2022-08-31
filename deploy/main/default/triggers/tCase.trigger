trigger tCase on Case (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    System.debug('OOE: ' + Trigger.operationType);

    switch on Trigger.operationType {
        when BEFORE_INSERT, BEFORE_UPDATE {
            for (Case c : Trigger.new) {
                c.Counter__c++;
                c.HTML__c += ' | ' + Trigger.operationType + ': ' + c.Counter__c;
            }
        }
    }
}