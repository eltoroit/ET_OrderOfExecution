# Contents

This project includes several demos:

1. Order Of Execution (Case records)
2. Order Of Execution (Account records)
3. Order Of Execution (`OrderOfExecution__c`)
4. Trigger.OLDs
5. Flows

# Order Of Execution (Case records)

# Order Of Execution (Account records)

# Order Of Execution (`OrderOfExecution__c` records)

# Trigger.OLDs

## Question being answered

When a trigger runs after a workflow field update, what is the actual value of trigger.old? Is it the original record from the database at the beginning of the Apex transaction, or is it the value at the beginning of the trigger execution?

## Metadata

-   Object: `TriggerOLD__c` (`Trigger.OLD`)
-   Apex Trigger: `tTriggerOLD`
-   Process: `TriggerOld`
-   Workflow: `Trigger.OLD: Plus 1`

## Demo (explained)

1. Open the developer console and start login
2. Create a new record, leave the default value as 0.
3. Open the debug log and notice
    - Each time the trigger runs, the trigger.old value is the value that was last saved.
    - Remember, there are multiple saves per Apex transaction

# General concepts

1. Triggers run after each field update action on the process, rather than after the whole process is complete. Make all field updates on a single action, rather than each field on its own action.
    - this is not true for workflows.
