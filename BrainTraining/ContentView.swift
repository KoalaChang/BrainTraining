//
//  ContentView.swift
//  BrainTraining
//
//  Created by 張宇涵 on 2025/12/12.
//

import SwiftUI

struct ContentView: View {

  let moves = ["rock", "paper", "scissors"]
  @State private var appsChoice = Int.random(in: 0...2)
  @State private var shouldWin = Bool.random()

  @State private var playerScore = 0
  @State private var rounds = 0
  @State private var activeAlert = false

  func moveTapped(_ move: String) {
    rounds += 1
    let winningMoves = ["paper", "scissors", "rock"]
    let losingMoves = ["scissors", "rock", "paper"]
    if shouldWin {
      if move == winningMoves[appsChoice] {
        playerScore += 1
      } else {
        playerScore -= 1
      }
    } else {
      if move == losingMoves[appsChoice] {
        playerScore += 1
      } else {
        playerScore -= 1
      }
    }

    if rounds == 10 {
      activeAlert = true
      return
    }

    shuffleMove()
  }

  func shuffleMove() {
    appsChoice = Int.random(in: 0...2)
    shouldWin = Bool.random()
  }

  func resetGame() {
    rounds = 0
    playerScore = 0
    shuffleMove()
  }

  private func emoji(for move: String) -> String {
    switch move {
    case "rock":
      return "✊"
    case "paper":
      return "✋"
    case "scissors":
      return "✌️"
    default:
      return "❓"
    }
  }

  var body: some View {
    ZStack {
      VStack {
        Text("Score: \(playerScore)")
          .font(.title)
        Spacer()
        appsMove
        Spacer()
        buttons
        Spacer()
      }
      .padding()
    }.alert("Your Score", isPresented: $activeAlert) {
      Button("Restart") {
        resetGame()
      }
    } message: {
      Text("Your score is \(playerScore)")
    }
  }

  @ViewBuilder
  private var appsMove: some View {
    VStack(spacing: 20) {
      VStack {
        Text("App's move")
          .font(.title)
        Text(moves[appsChoice])
          .font(.largeTitle)
          .foregroundStyle(.blue)
      }
      VStack {
        Text("Win or Lose")
          .font(.title)
        Text(shouldWin ? "Win" : "Lose")
          .font(.largeTitle)
          .foregroundStyle(.blue)
      }
    }
  }

  @ViewBuilder
  private var buttons: some View {
    HStack(spacing: 20) {
      ForEach(moves, id: \.self) {
        emojiButton(move: $0)
      }
    }
  }

  @ViewBuilder
  private func emojiButton(move: String) -> some View {
    Button(
      action: {
        moveTapped(move)
      },
      label: {
        Text(emoji(for: move))
      }
    )
    .buttonStyle(.borderedProminent)
    .buttonSizing(.flexible)
  }

}

#Preview {
  ContentView()
}
