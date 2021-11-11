//
//  BalotCalVM.swift
//  BalotCal
//
//  Created by Yasser Tamimi on 08/11/2021.
//

import Foundation

class BalotCalVM: ObservableObject {
    @Published private var model: Game = Game()

    var firstTeamScore: Int { model.firstTeam.score }
    var secondTeamScore: Int { model.secondTeam.score }
    var winningTeam: Game.TeamNumber? { model.winningTeam }


    // to store all scores for ui to show
    @Published private(set) var firstTeamScores = [Int]()
    @Published private(set) var secondTeamScores = [Int]()

    // MARK: - User Intent(s)
    func add(_ points: Int, to team: Game.TeamNumber) {
        switch team {
        case .first:
            firstTeamScores.append(points)
        case .second:
            secondTeamScores.append(points)
        }
        model.add(points, to: team)
    }

    func newGame() {
        model = Game()
        firstTeamScores = []
        secondTeamScores = []
    }

    func undo() {
        if let lastFirstTeamScore = firstTeamScores.last,
           let lastSecondTeamScore = secondTeamScores.last {
            // remove from mode
            model.deduct(lastFirstTeamScore, to: .first)
            // remove from array
            firstTeamScores.removeLast()
            
            // same for second team
            model.deduct(lastSecondTeamScore, to: .second)
            secondTeamScores.removeLast()
        }
    }

}
