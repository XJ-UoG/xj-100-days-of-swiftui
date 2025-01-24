//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tan Xin Jie on 12/1/25.
//

import SwiftUI

let initialTime = 10.0

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var scoreTitle = ""
    @State private var isShowingScore = false
    @State private var currentScore = 0
    @State private var highScore = 0
    
    @State private var isCorrectEffect = false
    @State private var isNewHighScoreEffect = false
    @State private var isWrongEffect = false
    
    @State private var isStarted = false
    @State private var maxTime = initialTime
    @State private var timeRemaining = initialTime
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .black],
                startPoint: .top,
                endPoint: UnitPoint(x: 0.5, y: timeRemaining / maxTime * 0.8)
            )
            .animation(.linear(duration: 0.1), value: timeRemaining)
            .overlay(
                Color.green
                    .opacity(isCorrectEffect ? 0.8 : 0.0)
                    .animation(.easeInOut(duration: 0.3), value: isCorrectEffect)
            )
            .overlay(
                Color.red
                    .opacity(isWrongEffect ? 0.8 : 0.0)
                    .animation(.easeInOut(duration: 0.3), value: isWrongEffect)
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("\(currentScore)")
                    .font(.title)
                    .scaleEffect(isCorrectEffect ? 3.0 : 1.0)
                    .animation(.spring(), value: isCorrectEffect)
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    Text("Tap the flag")
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                }
                .foregroundStyle(.white)
                VStack {
                    ForEach(0..<3) { num in
                        Button {
                            flagTapped(num)
                        } label: {
                            Image(countries[num])
                                .cornerRadius(3)
                                .shadow(radius: 5)
                        }
                    }
                }
                .padding(50)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
        }
        .alert(scoreTitle, isPresented: $isShowingScore) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("Your score is \(currentScore)")
        }
    }
    
    func startTimer() {
        guard !isStarted else { return }
        isStarted = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 0.1
            } else {
                scoreTitle = "Time Out"
                isShowingScore = true
                wrongEffect()
            }
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int){
        if !isStarted {
            startTimer()
        }
        
        if number == correctAnswer {
            currentScore += 1
            if timeRemaining < maxTime{
                timeRemaining += 3
            }
            correctEffect()
            askQuestion()
        } else {
            scoreTitle = "Wrong Answer"
            isShowingScore = true
            wrongEffect()
        }
    }
    
    func resetGame() {
        currentScore = 0
        maxTime = initialTime
        timeRemaining = initialTime
        isStarted = false
        timer?.invalidate()
        askQuestion()
    }
    
    func correctEffect() {
        withAnimation {
            isCorrectEffect = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            withAnimation {
                isCorrectEffect = false
            }
        }
    }
    
    func wrongEffect() {
        withAnimation {
            isWrongEffect = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            withAnimation {
                isWrongEffect = false
            }
        }
    }
}

#Preview {
    ContentView()
}
