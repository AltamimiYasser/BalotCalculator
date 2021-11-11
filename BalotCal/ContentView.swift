//
//  ContentView.swift
//  BalotCal
//
//  Created by Yasser Tamimi on 08/11/2021.
//
import SwiftUI
import Combine


struct ContentView: View {

    init() {
        UIScrollView.appearance().bounces = false
    }

    @StateObject var vm = BalotCalVM()

    @State var usScore = ""
    @State var themScore = ""
    @State var buttonText = "سجل"
    @State var newGameMode = false

    var body: some View {
        // whole VStack
        NavigationView {
            VStack {
                ZStack {
                    VerticalLine().stroke(lineWidth: 3).frame(width: 3)
                    //
                    // header
                    VStack {
                        HStack(spacing: 70) {
                            Text("لهم").font(.largeTitle).padding()
                            Text("لنا").font(.largeTitle).padding()
                        }
                            .padding()
                        HorizontalLine().stroke(lineWidth: 3).frame(height: 3)
                        //
                        //                    // VStack for results
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(vm.firstTeamScores.indices, id: \.self) { i in
                                    HStack(spacing: 100) {
                                        Text("\(vm.secondTeamScores[i])").font(.headline)
                                        Text("\(vm.firstTeamScores[i])").font(.headline)
                                    }
                                }

                            }
                                .padding(.vertical)
                        }
                        HStack(spacing: 140) {
                            Text("\(vm.secondTeamScore)")
                                .font(.title)
                                .underline()
                                .padding()
                                .background(vm.winningTeam == .second ? Color.green : Color.clear)
                                .cornerRadius(10)

                            Text("\(vm.firstTeamScore)")
                                .font(.title)
                                .underline()
                                .padding()
                                .background(vm.winningTeam == .first ? Color.green : Color.clear)
                                .cornerRadius(10)
                        }
                            .padding()
                        Spacer()
                    }

                }
                    .onTapGesture {
                    dismissKeyboard()
                }
                HStack(spacing: 20) {
                    RegisterTextField(text: $themScore, textInTextField: "لهم")

                    Button {
                        addScore()
                    } label: {
                        Text(buttonText)
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(Color.red.cornerRadius(10))
                            .foregroundColor(.white)
                    }

                    RegisterTextField(text: $usScore, textInTextField: "لنا")
                }
                    .padding(.horizontal)
            }
                .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {

                    Image(systemName: "arrow.uturn.backward.square.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .frame(alignment: .leading)
                        .onTapGesture {
                            vm.undo()
                        }
                }
            }
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    func addScore() {

        // if game has ended
        if newGameMode {
            buttonText = "سجل"
            newGameMode.toggle()
            vm.newGame()
        }

        // make sure both are there and both are numbers
        guard usScore.count >= 1 || themScore.count >= 1 else { return }

        // before we check both are int, we need to know if only one has number
        // then the other one will get 0
        if usScore.count >= 1 && themScore.count < 1 { themScore = "0" }
        else if themScore.count >= 1 && usScore.count < 1 { usScore = "0" }

        // check both are int
        guard usScore.isInt && themScore.isInt else { return }
        vm.add(Int(usScore) ?? 0, to: .first)
        vm.add(Int(themScore) ?? 0, to: .second)
        usScore = ""
        themScore = ""
        dismissKeyboard()

        // change the button to play new game
        if let _ = vm.winningTeam {
            buttonText = "صكة جديدة"
            newGameMode.toggle()
        }
    }

    func dismissKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct RegisterTextField: View {

    @Binding var text: String
    let textInTextField: String

    var body: some View {
        TextField(textInTextField, text: $text)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(text)) { newValue in
            let filtered = newValue.filter { "0123456789".contains($0) }
            if filtered != newValue {
                text = filtered
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)

    }
}

