//
//  Game.swift
//  BalotCal
//
//  Created by Yasser Tamimi on 08/11/2021.
//

import Foundation
import SwiftUI


struct Game {

    var firstTeam = Team(teamNumber: .first)
    var secondTeam = Team(teamNumber: .second)
    let WINNING_SCORE = 152
    var winningTeam: TeamNumber?


    mutating func add(_ points: Int, to teamNumber: TeamNumber) {
        switch teamNumber {
        case .first:
            firstTeam.score += points
        case .second:
            secondTeam.score += points
        }
        if (firstTeam.score >= WINNING_SCORE && secondTeam.score >= WINNING_SCORE) {
            winningTeam = firstTeam.score > secondTeam.score ? firstTeam.teamNumber : secondTeam.teamNumber
        } else if firstTeam.score >= WINNING_SCORE {
            winningTeam = firstTeam.teamNumber

        } else if secondTeam.score >= WINNING_SCORE {
            winningTeam = secondTeam.teamNumber
        }
    }


    struct Team {
        let teamNumber: TeamNumber
        var score = 0
    }

    enum TeamNumber {
        case first, second
    }
}
