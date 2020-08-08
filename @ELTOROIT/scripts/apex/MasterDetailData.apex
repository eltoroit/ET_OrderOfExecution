DELETE [SELECT Id FROM MDGrandParent__c];
DELETE [SELECT Id FROM MDParent__c];
DELETE [SELECT Id FROM MDChild__c];

Integer iGP = 0;
Integer iP = 0;
Integer iC = 0;

List<MDGrandParent__c> gps = new List<MDGrandParent__c>();
for (iGP = 1; iGP <= 5; iGP++) {
    gps.add(new MDGrandParent__c(Name='GP0'+iGP, Counter__c = iGP));
}
insert gps;

List<MDParent__c> ps = new List<MDParent__c>();
for (MDGrandParent__c gp : gps) {
    // for (iP = 1; iP <= gp.Counter__c; iP++) {
    for (iP = 1; iP <= 5; iP++) {
        ps.add(new MDParent__c(Name=gp.Name+'_P0'+iP, Counter__c = iP, GrandParent__c = gp.Id));
    }
}
insert ps;

List<MDChild__c> cs = new List<MDChild__c>();
for (MDParent__c p : ps) {
    // for (iC = 1; iC <= p.Counter__c; iC++) {
    for (iC = 1; iC <= 5; iC++) {
        cs.add(new MDChild__c(Name=p.Name+'_C0'+iC, Counter__c = iC, Parent__c = p.Id));
    }
}
insert cs;

