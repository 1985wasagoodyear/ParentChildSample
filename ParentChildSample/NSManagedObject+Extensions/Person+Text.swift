//
//  Person+Text.swift
//  ParentChildSample
//
//  Created by K Y on 10/22/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

extension Person {
    
    override public var description: String {
        let t =
        """
        Name: \(name!)
        Age: \(age)
        Occupation: \(occupation!)
        """
        return t
    }
    
    func randomizeDetails() {
        name = Person.randomName()
        age = Int16(Int.random(in: 18...108))
        occupation = Person.randomOccupation()
        usleep(useconds_t.random(in: 0..<1000000)) // randomly wait 0-1 second(s) to simulate a delay
    }
    
}

extension Person {
    
    class func randomName() -> String {
        let names = ["Alice", "Bob", "Carol", "Dean"]
        let i = Int.random(in: 0..<names.count)
        return names[i]
        
    }
    
    class func randomOccupation() -> String {
        let occupations = ["Builder", "Carpenter", "Electrician", "Astronaut"]
        let i = Int.random(in: 0..<occupations.count)
        return occupations[i]
    }
    
}
