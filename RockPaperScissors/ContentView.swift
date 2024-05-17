//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Om Preetham Bandi on 5/17/24.
//

import SwiftUI

struct ContentView: View {
    var moves: [String] = ["Rock", "Paper", "Scissors"]
    var gameLength: Int = 10
    
    @State private var selectedMove: Int = 0
    @State private var shouldWin: Bool = true
    @State private var playerScore: Int = 0
    @State private var round: Int = 1
    @State private var gameOver: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack {
                    if !gameOver {
                        Text("Round \(round) / \(gameLength)")
                            .padding()
                            .font(.largeTitle)
                        Text("Player Score: \(playerScore)")
                            .font(.largeTitle)
                    } else {
                        Text("Game Over!")
                            .padding()
                            .font(.largeTitle)
                    }
                                        
                    if !gameOver {
                        Text("Computer: \(moves[selectedMove])")
                            .font(.largeTitle)
                            .padding()
                        Text("You: \(shouldWin ? "Win" : "Lose")")
                            .font(.largeTitle)
                    } else {
                        Text("Final Score: \(playerScore)")
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                                        
                    if !gameOver {
                        HStack {
                            ForEach(moves, id: \.self) { move in
                                Button(action: {
                                    self.checkGame(move: move)
                                }) {
                                    Text(move)
                                }
                                .foregroundColor(.primary)
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    } else {
                        Button(action: {
                            self.restartGame()
                        }) {
                            Text("Restart Game")
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Rock Paper Scissors")
            }
        }
    }
    
    func checkGame(move: String) {
        let computerMove = moves[selectedMove]
        
        // Determine the result of the game
        var playerWins: Bool = false
        
        switch (move, computerMove) {
        case ("Rock", "Scissors"), ("Paper", "Rock"), ("Scissors", "Paper"):
            playerWins = true
        case ("Rock", "Paper"), ("Paper", "Scissors"), ("Scissors", "Rock"):
            playerWins = false
        default:
            playerWins = false // Draw
        }
        
        // Update player's score based on the result
        if playerWins == shouldWin {
            playerScore += 1
        } else {
            playerScore -= 1
        }
  
        selectedMove = Int.random(in: 0..<moves.count)
        
        // Update round count and check for game over
        round += 1
        if round > gameLength {
            gameOver = true
        }
        
        // Toggle shouldWin for the next round
        shouldWin.toggle()
    }
    
    func restartGame() {
        selectedMove = 0
        shouldWin = true
        playerScore = 0
        round = 1
        gameOver = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
