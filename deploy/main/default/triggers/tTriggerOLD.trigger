trigger tTriggerOLD on TriggerOLD__c(before update, after update) {
	for (TriggerOLD__c newRecord : Trigger.new) {
		String new1 = newRecord.Dummy__c;
		String old1 = Trigger.oldMap.get(newRecord.Id).Dummy__c;

		if (Trigger.isBefore) {
			// if (newRecord.Dummy__c.length() == 1) {
				System.debug('=== Changed on trigger ===');
				newRecord.Dummy__c = '=== ' + newRecord.Dummy__c + ' ===';
			// }
		}

		String new2 = newRecord.Dummy__c;
		String old2 = Trigger.oldMap.get(newRecord.Id).Dummy__c;

		String s = '';
		s += 'trigger.old: START: [' + old1 + '] >> END: [' + old2 + '] ';
		s += 'trigger.new: START: [' + new1 + '] >> END: [' + new2 + '] ';
		s += 'EVENT: [' + Trigger.operationType + '] ';
		System.debug(s);
	}
}
