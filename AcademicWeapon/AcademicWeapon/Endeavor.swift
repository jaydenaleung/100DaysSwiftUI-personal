//
//  Endeavor.swift
//  AcademicWeapon
//
//  Created by Jayden Leung on 10/30/24.
//

import Foundation

struct Endeavor: Identifiable, Codable {
    var name: String
    var desc: String
    var timeTaking: Int
    var timeEndGoal: Int
    var date: Date
    
    var id = UUID()
    
    var timeNextGoal: Int { timeTaking + computedInterval }
    var goalIsMet: [Bool] = []
    var computedInterval: Int { // NEGATIVE to decrement, POSITIVE to increment
        // CODE FOR CALCULATING WHAT THE INTERVAL BETWEEN THIS WEEK AND NEXT IS, BASED ON CURRENT IMPROVMENTS AND PERFORMANCE
        
        func smallIntervalTest() -> Int {
            if timeTaking - timeEndGoal < 5 { // if it's less than 5 minutes until the goal
                return -(timeTaking - timeEndGoal)
            } else {
                return 0
            }
        }
        
        if timeTaking > timeEndGoal { // decrement
            if goalIsMet.isEmpty { // initial goal
                if smallIntervalTest() != 0 { return smallIntervalTest() }
                return -5
            } else if goalIsMet.last ?? true { // if last week's goal is successful
                if smallIntervalTest() != 0 { return smallIntervalTest() }
                return -10
            } else { // if last week's goal is not successful
                if smallIntervalTest() != 0 { return smallIntervalTest() }
                return -5
            }
        } else if timeTaking < timeEndGoal { // increment
            if goalIsMet.isEmpty { // initial goal
                if smallIntervalTest() != 0 { return smallIntervalTest() }
                return 5
            } else if goalIsMet.last ?? true { // if last week's goal is successful
                if smallIntervalTest() != 0 { return smallIntervalTest() }
                return 10
            } else { // if last week's goal is not successful
                if smallIntervalTest() != 0 { return smallIntervalTest() }
                return 5
            }
        } else { // equal - either initial time and goal are the same or goal has been reached
            return 0
        }
    }
}
