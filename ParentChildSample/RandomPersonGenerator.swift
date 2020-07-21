//
//  RandomPersonGenerator.swift
//  ParentChildSample
//
//  Created by K Y on 10/22/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

public class RandomPersonGenerator {
    
    private let manager = CoreDataManager()
    
    // MARK: - Timer-related Properties
    
    private let updateInterval: TimeInterval
    private let makeInterval: TimeInterval
    private var updateTimer: Timer?
    private var makeTimer: Timer?
    private var update: (()->Void)?
    
    // MARK: -
    public var persons: [Person] = []
    public var useCorrectMethod: Bool = true
    public var isMakingPeople: Bool {
        return updateTimer != nil && makeTimer != nil
    }
    
    public init(updateInterval: TimeInterval,
         makeInterval: TimeInterval,
         update: (()->Void)? = nil) {
        self.updateInterval = updateInterval
        self.makeInterval = makeInterval
        self.update = update
    }
    
    public func start() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: updateInterval,
                                           repeats: true) { _ in
                                            self.manager.fetchData({ (persons) in
                                                self.persons = persons
                                                self.update?()
                                            })
        }
        makeTimer = Timer.scheduledTimer(withTimeInterval: makeInterval,
                                         repeats: true) { _ in
                                            if self.useCorrectMethod {
                                                self.manager.makePerson()
                                            } else {
                                                self.manager.makePerson_wrongWay()
                                            }
        }
    }
    
    public func stop() {
        updateTimer?.invalidate()
        makeTimer?.invalidate()
        updateTimer = nil
        makeTimer = nil
    }
    
}
