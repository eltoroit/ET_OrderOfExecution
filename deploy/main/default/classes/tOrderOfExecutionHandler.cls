public without sharing class tOrderOfExecutionHandler {
	private static Decimal fraction = 0.1;
	private static Boolean fireTrigger = true;
	private static Integer updateTriggerCounter = 0;
	private static Set<Id> scheduledRecords = new Set<Id>();

	@future
	private static void reformatCode(Set<Id> recordIds) {
		Integer loopCounter = 0;
		Boolean updates = false;
		List<OrderOfExecution__c> records = [SELECT Id, Execute__c, Counter__c, Dummy__c FROM OrderOfExecution__c WHERE Id IN :recordIds];
		for (OrderOfExecution__c record : records) {
			if (record.Execute__c) {
				updates = true;
				System.debug(record.Dummy__c);

				String s = '';
				s += '<ol>';
				Boolean isCurrentWF = false;
				Boolean isPreviousWF = false;
				for (String part : record.Dummy__c.split('\\|')) {
					part = part.trim();
					isPreviousWF = isCurrentWF;
					isCurrentWF = part.startsWith('Workflow');
					if (!isPreviousWF && isCurrentWF) {
						if (loopCounter == 0) {
							s += '<li style="color:red">First Pass</li>';
						} else {
							s += '<li style="color:red">' + 'Repeat #' + loopCounter + '</li>';
						}
						loopCounter++;
					}
					s += '<li style="color:' + (part.contains('Trigger') ? 'blue' : 'black') + '">' + part + '</li>';
				}
				s += '</ol>';

				record.Dummy__c = s;
				record.Execute__c = false;
				System.debug(record.Dummy__c);
			}
		}
		if (updates) {
			fireTrigger = false;
			update records;
		}
	}

	public static void handleTrigger(List<OrderOfExecution__c> tNew, Map<Id, OrderOfExecution__c> toldMap) {
		if (fireTrigger) {
			Boolean Scheduled = false;
			for (OrderOfExecution__c newRecord : tNew) {
				if (Trigger.isInsert || newRecord.Execute__c) {
					// Add Id to process
					if (Trigger.isAfter) {
						if (!scheduledRecords.contains(newRecord.Id)) {
							scheduled = true;
							scheduledRecords.add(newRecord.Id);
						}
					}

					switch on Trigger.operationType {
						when BEFORE_INSERT {
							// Initialize record
							updateTriggerCounter = 1;
							newRecord.Counter__c = 11 * fraction;
							newRecord.Execute__c = true;
							newRecord.Dummy__c += ' | Insert Trigger: 0.0 > ' + newRecord.Counter__c;
							System.debug('FINDME: ' + Trigger.operationType + ' | Counter__c null >>> ' + newRecord.Counter__c);
						}
						when BEFORE_UPDATE {
							// Update record
							Decimal oldCounter = newRecord.Counter__c;

							newRecord.Counter__c++;
							if (newRecord.Counter__c > 25) {
								fraction += 0.1;
								newRecord.Counter__c = 11 * fraction;
							}

							newRecord.Dummy__c += ' | Update Trigger (' + updateTriggerCounter + '): ' + oldCounter + ' > ' + newRecord.Counter__c;
							System.debug('FINDME: ' + Trigger.operationType + '(' + updateTriggerCounter + ') | Counter__c ' + oldCounter + ' >>> ' + newRecord.Counter__c + ' (' + newRecord.Dummy__c + ')');
							updateTriggerCounter++;
						}
						when AFTER_INSERT {
							// Nothing
						}
						when AFTER_UPDATE {
							// Nothing
						}
						when else {
							throw new IllegalArgumentException('Trigger type not expected');
						}
					}
				}
			}
			if (scheduled) {
				reformatCode(scheduledRecords);
			}
		}
	}
}
