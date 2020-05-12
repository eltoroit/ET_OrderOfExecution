trigger tOrderOfExecution on OrderOfExecution__c(before insert, after insert, before update, after update) {
	tOrderOfExecutionHandler.handleTrigger(Trigger.new, Trigger.oldMap);
}
