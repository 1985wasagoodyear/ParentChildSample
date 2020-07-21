//
//  CoreDataManager+Person.swift
//  ParentChildSample
//
//  Created by K Y on 10/22/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import CoreData

extension CoreDataManager {
    func fetchData(_ completion: @escaping ([Person])->Void) {
        let context = mainContext
        let desc = NSEntityDescription.entity(forEntityName: "Person",
                                              in: context)!
        // contexts can do work on their own thread
        context.perform {
            let request = NSFetchRequest<Person>()
            request.entity = desc
            // let request: NSFetchRequest<Person> = Person.fetchRequest()
            let results = try! context.fetch(request)
            completion(results)
        }
    }
    
    func loadPeople() -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        return try! mainContext.fetch(request)
    }
    
    // do NOT simply dispatch work to a background thread
    // for a mainQueueConcurrencyType context
    // crashes after ~15 seconds
    func makePerson_wrongWay() {
        DispatchQueue.global().async {
            let context = self.mainContext
            let desc = NSEntityDescription.entity(forEntityName: "Person",
                                                  in: context)!
            let person = Person(entity: desc, insertInto: context)
            person.randomizeDetails()
            
            // no need to save since it is already made on the main-thread-context
        }
    }
    
    func makePerson() {
        let context = backgroundContext
        context.perform {
            let desc = NSEntityDescription.entity(forEntityName: "Person",
                                                  in: context)!
            let person = Person(entity: desc, insertInto: context)
            person.randomizeDetails()
            
            // propogate this person into our main-thread-context
            try! context.save()
        }
    }
}
