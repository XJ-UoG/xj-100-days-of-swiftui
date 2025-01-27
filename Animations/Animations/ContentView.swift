//
//  ContentView.swift
//  Animations
//
//  Created by Tan Xin Jie on 27/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sizeAmount = 1.0
    @State private var sizeState = false
    
    @State private var idlePulseAmount = 1.0
    @State private var sendPulseAmount = 0.0
    @State private var isPulsePressed = false
    
    @State private var spinAmount = 0.0
    
    @State private var isMorph = false
    
    @State private var dragAmount = CGSize.zero
    
    @State private var isWave = false
    @State private var waveAmount = CGSize.zero
    
    @State private var isShowHidden = false
    
    
    var body: some View {
        VStack {
            // Shrink Button
            Button(sizeState ? "Grow" : "Shrink") {
                if sizeState {
                    sizeAmount += 0.5
                } else {
                    sizeAmount -= 0.5
                }
                sizeState.toggle()
            }
            .padding(50)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(sizeAmount)
            .animation(.default, value: sizeAmount)
            
            // Pulse Button
            Button("Pulse") {
                if !isPulsePressed {
                    isPulsePressed = true
                    sendPulseAmount = 2
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        sendPulseAmount = 0
                        isPulsePressed = false
                    }
                }
            }
            .disabled(isPulsePressed)
            .padding(50)
            .background(.teal)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .overlay(
                Circle()
                    .stroke(.teal)
                    .scaleEffect(idlePulseAmount)
                    .opacity(2 - idlePulseAmount)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                        value: idlePulseAmount
                    )
            )
            .overlay(
                Circle()
                    .stroke(.purple, lineWidth: 3)
                    .scaleEffect(sendPulseAmount * 1.5)
                    .opacity(2 - sendPulseAmount)
                    .animation(sendPulseAmount == 2 ? .easeInOut(duration: 1) : .none, value: sendPulseAmount)
            )
            .onAppear {
                idlePulseAmount = 2
            }
            
            // Spin Button
            Button("Spin") {
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    spinAmount += 360
                }
            }
            .padding(50)
            .background(.green)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(spinAmount), axis: (x: 0, y: 1, z: 0))
            
            // Morph Button
            Button("Morph") {
                isMorph.toggle()
            }
            .frame(width: 120, height: 120)
            .background(!isMorph ? .gray : .mint)
            .animation(.default, value: isMorph)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: !isMorph ? 100 : 0))
            .animation(.spring(duration: 1, bounce: 0.5), value: isMorph)
            
            // Drag Button
            ZStack {
                LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 120, height: 120)
                    .clipShape(.circle)
                Text("Drag")
                    .foregroundColor(.white)
            }
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in dragAmount = .zero }
            )
            .animation(.bouncy, value: dragAmount)
            
            // Wave Button
            let letters = Array("Wave!!!")
            HStack(spacing: 0) {
                ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(isWave ? .white : .red)
                        .offset(y: isWave ? CGFloat(num % 2 == 0 ? -20 : 20) : 0)
                        .animation(
                            .easeInOut(duration: 0.6).delay(Double(num) / 10),
                            value: isWave
                        )
                }
            }
            .onTapGesture {
                isWave.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isWave.toggle()
                }
            }
            Spacer()
            // Hidden
            VStack (alignment: .center) {
                if !isShowHidden {
                    Button("secret") {
                        withAnimation {
                            isShowHidden.toggle()
                        }
                    }
                    .foregroundColor(.gray)
                    .opacity(0.5)
                } else {
                    HStack {
                        Text("🥷")
                            .font(.system(size: 50))
                            .frame(height: 80)
                            .onTapGesture {
                                withAnimation {
                                    isShowHidden.toggle()
                                }
                        }
                        Text("hi there!")
                    }
                    .transition(.scale)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
