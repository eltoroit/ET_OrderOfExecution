trigger tFlow on Flow__c(before insert, before update) {
	for (Flow__c newRecord : Trigger.new) {
		String msg = '';
		Decimal old = Trigger.oldMap?.get(newRecord.Id).Counter__c;
		Decimal new1 = newRecord.Counter__c;

		System.debug('OOE: === ' + Trigger.operationType);
		System.debug('OOE: Trigger.old: [' + old + ']');
		System.debug('OOE: Last updated by: ' + newRecord.Who__c + '. Changed value [' + old + '] >> [' + new1 + ']');

		switch on Trigger.operationType {
			when BEFORE_INSERT, BEFORE_UPDATE {
				newRecord.Counter__c++;
				newRecord.Who__c = 'Trigger';
			}
		}

		Decimal new2 = newRecord.Counter__c;
		System.debug('OOE: Trigger changed value [' + new1 + '] >> [' + new2 + '] ');
	}
}
