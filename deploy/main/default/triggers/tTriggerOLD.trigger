trigger tTriggerOLD on TriggerOLD__c(before update, after update) {
	for (TriggerOLD__c newRecord : Trigger.new) {
		String s;
		String new1 = newRecord.Dummy__c;
		String old1 = Trigger.oldMap.get(newRecord.Id).Dummy__c;

		if (Trigger.isBefore) {
			if (newRecord.Dummy__c.length() == 1) {
				System.debug('=== Changed on trigger ===');
				newRecord.Dummy__c = '=== ' + newRecord.Dummy__c + ' ===';
			}
		}

		String new2 = newRecord.Dummy__c;
		String old2 = Trigger.oldMap.get(newRecord.Id).Dummy__c;

		s = '';
		s += '[OLD: ' + old1 + ' >> ' + old2 + '] ';
		s += '[NEW: ' + new1 + ' >> ' + new2 + '] ';
		s += '[EVENT: ' + (Trigger.isBefore ? 'Before' : 'After') + '] ';
		System.debug(s);
	}
}
