//
//  AddTask.swift
//  TimePad
//
//  Created by Anday on 22.07.21.
//

import SwiftUI

struct AddTaskScreenView: View {
    @StateObject var vm: AddTaskViewModel = AddTaskViewModel()
    var body: some View {
        ScrollView {
            VStack {
                
                TextField("Title", text: $vm.title)
                    .font(.title2)
                    .padding()
                    .background(Color.theme.accent.cornerRadius(12))
                
                
                DatePicker("Date", selection: $vm.date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .background(Color.theme.accent.cornerRadius(12))
                    .accentColor(Color.theme.gradientPurple)
                
                
                Text("Duration")
                    .bold()
                    .font(.title)
                    .padding()
                
                TimeStepper(title: "Hours", value: $vm.durationHours, upperBound: 24, lowerBound: 0)
                TimeStepper(title: "Minutes", value: $vm.durationMinutes, upperBound: 60, lowerBound: 0)                
                
                
                
                
                Spacer()
                
            }.padding()
        }
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTaskScreenView()
                .navigationTitle("New Task 🔖")
        }
    }
}


struct TimeStepper: View {
    var title: String
    @Binding var value: Int
    var upperBound: Int?
    var lowerBound: Int?
    var body: some View {
        Stepper(
            onIncrement: {
                guard let upperBound = upperBound else {
                    value += 1
                    return
                }
                if(value < upperBound){
                    value += 1
                }
            },
            onDecrement: {
                guard let lowerBound = lowerBound else {
                    value -= 1
                    return
                }
                if(value > lowerBound){
                    value -= 1
                }
            },
            label: {
                HStack {
                    Text(title)
                        .font(.title3)
                    Spacer()
                    Text("\(value)")
                        .font(.title2)
                        .padding(.horizontal)
                }
                
            })
            .padding()
            .background(Color.theme.accent.cornerRadius(12))
            .accentColor(Color.theme.gradientPurple)
    }
}
