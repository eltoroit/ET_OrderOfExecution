# Contents

This project includes several demos:

1. Trigger.old values
2. Order Of Execution (Case records)
3. Order Of Execution (`OrderOfExecution__c`)
4. Flows

# Trigger.old values

## Question being answered

When a trigger runs after a workflow field update, what is the actual value of trigger.old? Is it the original record from the database at the beginning of the Apex transaction, or is it the value at the beginning of the trigger execution?

## Demo

1. Open the developer console and start loging
2. Create a new `Trigger.OLD` record, leave the default values.
3. Open the debug log and notice
    - Each time the trigger runs, the trigger.old value is the value that was last saved.
    - Remember, there are multiple saves per Apex transaction

# Order Of Execution (Case records)

## Question being answered

Can we see the steps that are happenning and confirm the circle discussed in the presentation? The best object for that would be the case object because it has all the elements in the circle including escalation rules and assignment rules).

## Demo

1. Open the developer console and start loging
2. Create a new `Case` record,
    - Select any values for Contact, Account, Status and Origin
3. Open the debug log and notice
    - Filter by 'OOE'
    - View the Order Of Execution steps happening
    - The triggers will fire multiple times

# Order Of Execution (`OrderOfExecution__c` records)

## Question being answered

This demo explains the loops inside teh OOE.
Do triggers run multiple times in a transaction? YES! Be careful with Governor Limits!!!

## Demo

1. Create a new `OrderOfExecution__c` record
2. View the `dummy` field to understand how the execution happened.

# Flows

## Question being answered

How do flows work with the OOE?

## Demo

1. Open the developer console and start loging
2. Create a new `Flow` record, leave the default values.
3. Open the debug log and notice
    - FF flows
        - Seem to run in a separate transation when running from the page layout.
        - They are part of the same transaction (log file) when creating the record from execute anonymous
        - They do not fire any additional logic, since everything will start after they run anyways
    - ARR flows
        - If the same record is updated, only triggers and validation rules will be executed
        - If they create other records, then the whole OOE will beexecuted

# General concepts

1. Triggers run after each field update action on the process, rather than after the whole process is complete. Make all field updates on a single action, rather than each field on its own action.
    - this is not true for workflows.
