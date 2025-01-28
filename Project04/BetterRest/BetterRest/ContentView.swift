//
//  ContentView.swift
//  BetterRest
//
//  Created by Tan Xin Jie on 25/1/25.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 10){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    HStack {
                        Image(systemName: "alarm.waves.left.and.right")
                        Spacer()
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .onChange(of: wakeUp){ _ in calculateBedTime()}
                    }
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .onChange(of: sleepAmount){ _ in calculateBedTime()}
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("Daily coffe intake")
                        .font(.headline)
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                        .onChange(of: coffeeAmount){ _ in calculateBedTime()}
                }
                Section("Calculated bedtime"){
                    HStack {
                        Spacer()
                        Image(systemName: "bed.double.fill")
                        Text("Sleep at")
                        Text("\(alertMessage)")
                            .font(.title)
                        Spacer()
                    }
                    .listRowBackground(Color.blue.opacity(0.3))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    HStack {
                        Text("BetterRest")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                        Image(systemName: "moon.stars")
                    }
                }
            }
        }
        .onAppear(perform: {
            calculateBedTime()
        })
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertMessage = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
    }
}

#Preview {
    ContentView()
}
