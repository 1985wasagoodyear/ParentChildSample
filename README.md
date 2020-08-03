# Parent Child Sample

A sample of Parent-Child Contexts for Concurrency in Core Data.

## Sample Summary

There are two modes to generate a  `Person`, our `NSManagedObjectModel` entity for Core Data:

1. the **Right** way

	* Using Parent-Child contexts (unsurprisingly)

2. the **Wrong** way

	* Passing around a single context to different DispatchQueues.
	* Unsurprisingly, this way will eventually lead to a crash some non-determinstic time in the future.


## Parent-Child Contexts

Are the main means of multithreading for Core Data.

A child context can **retrieve** data from its parent with an `NSFetchRequest`.

A child context can **send** data to its parent by calling its `save()` method.

Any context is made for a specific thread, and should only be used on said thread. Any context can **perform work on its specific thread** with its `perform(_:)` and `performAndWait(_:)`methods.


##  Resources

1. [Apple Developer - Core Data Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/index.html#//apple_ref/doc/uid/TP40001075-CH2-SW1)


2. [Core Data and Concurrency](https://cocoacasts.com/core-data-and-concurrency)

	A good discussion and breakdown of parent-child contexts.


3. [EXPERIMENTING WITH THE PARENT-CHILD CONCURRENCY PATTERN TO OPTIMIZE COREDATA APPS](http://developmentnow.com/2015/04/28/experimenting-with-the-parent-child-concurrency-pattern-to-optimize-coredata-apps/)

	A good analysis of parent-child contexts with respect to a singly-threaded context approach.
