trigger WhenDoTriggersRun on Account(before update, after insert) {
    //  System.debug('WHEN: ' + Trigger.operationType);
    System.debug(Trigger.isAfter ? 'AFTER' : 'BEFORE');
}