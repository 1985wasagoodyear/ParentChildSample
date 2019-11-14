#  Migration

* occur when your data model changes
* new app uses the new model, it needs to migrate any saved models


# Two main types:

1. Lightweight
2. Heavyweight (manual migration)


## Lightweight

* no changes, no work
* existing models are automatically migrated over.


## Heavyweight 

* if you do not handle this, your app crashes
* new models are too different from your old models
* include a mapping model for EACH version of your MOM.
* contains:
        * each version of your MOM
        * describe how to convert one version to the next version



## When is a heavyweight migration? When is a lightweight migration?

* it depends on what Core Data thinks

