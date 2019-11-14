//
//  RandomPersonGenerator.swift
//  ParentChildSample
//
//  Created by K Y on 10/22/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

class RandomPersonGenerator {
    
    let manager = CoreDataManager()
    
    let updateInterval: TimeInterval
    let makeInterval: TimeInterval
    
    var updateTimer: Timer?
    var makeTimer: Timer?
    
    var persons: [Person] = []
    var update: (()->Void)?
    
    init(updateInterval: TimeInterval,
         makeInterval: TimeInterval,
         update: (()->Void)? = nil) {
        self.updateInterval = updateInterval
        self.makeInterval = makeInterval
        self.update = update
    }
    
    func start() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: updateInterval,
                                           repeats: true) { _ in
                                            self.manager.fetchData({ (persons) in
                                                self.persons = persons
                                                self.update?()
                                            })
        }
        makeTimer = Timer.scheduledTimer(withTimeInterval: makeInterval,
                                         repeats: true) { _ in
                                            self.manager.makePerson()
                                            print("made item")
        }
    }
    
    func stop() {
        updateTimer?.invalidate()
        makeTimer?.invalidate()
    }
    
}
