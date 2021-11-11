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
    var winningTeam: Game.TeamNumber? { model.winningTeam}
    

    // to store all scores for ui to show
    @Published private(set) var firstTeamScores = [TeamScore]()
    @Published private(set) var secondTeamScores = [TeamScore]()

    // MARK: - User Intent(s)
    func add(_ points: Int, to team: Game.TeamNumber) {
        switch team {
        case .first:
            firstTeamScores.append(TeamScore(value: points))
        case .second:
            secondTeamScores.append(TeamScore(value: points))
        }
        model.add(points, to: team)
    }
    
    func newGame() {
        model = Game()
        firstTeamScores = []
        secondTeamScores = []
    }

    struct TeamScore: Identifiable {
        let id = UUID()
        let value: Int
    }

}
