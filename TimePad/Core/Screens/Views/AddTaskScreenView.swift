//
//  AddTask.swift
//  TimePad
//
//  Created by Anday on 22.07.21.
//

import SwiftUI

struct AddTaskScreenView: View {
    @StateObject var vm: AddTaskViewModel = AddTaskViewModel()
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some View {
        VStack {
            Form {
                
                Section {
                    TextField("Title", text: $vm.title)
                        .font(.title2)
                        .padding()
                        .background(Color.theme.accent.cornerRadius(12))
                        .padding(.bottom, 8)
                    
                    
                    
                    DatePicker("Date", selection: $vm.date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(Color.theme.accent.cornerRadius(12))
                        .accentColor(Color.theme.gradientPurple)
                        
                    
                }
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemBackground))

                
                Section(
                    header: Text("Duration")
                        .bold()
                        .font(.title3)
                ){
                    TimePicker(title: "Minutes", value: $vm.durationMinutes, upperBound: 60, lowerBound: 1)
                        .padding(.bottom, 8)
                    
                    TimeStepper(title: "Hours", value: $vm.durationHours, upperBound: 24, lowerBound: 0)
                    
                    
                    
                }
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemBackground))
                
                
            }
            
        }
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTaskScreenView()
                .navigationTitle("New Task 🔖")
                .preferredColorScheme(.dark)
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
                        .foregroundColor(Color.theme.gradientPurple)
                }
                
            })
            .padding()
            .background(Color.theme.accent.cornerRadius(12))
            .accentColor(Color.theme.gradientPurple)
    }
}


struct TimePicker: View {
    var title: String
    @Binding var value: Int
    var upperBound: Int?
    var lowerBound: Int?
    
    var body: some View {
        Picker(selection: $value,
               label: labelView,
               content: {contentView}
        )
        .pickerStyle(MenuPickerStyle())
        .padding()
        .background(Color.theme.accent.cornerRadius(12))
        .accentColor(Color.theme.gradientPurple)
    }
}


extension TimePicker {
    private var labelView: some View {
        HStack {
            Text(title)
                .font(.title3)
                .foregroundColor(.primary)
            Spacer()
            Text("\(value)")
                .font(.title2)
            
            
            Image(systemName: "chevron.right")
                .font(.subheadline)
                .foregroundColor(.primary)
            
        }
    }
    
    private var contentView: some View {
        ForEach((lowerBound ?? 0)...(upperBound ?? 60), id: \.self) { index in
            Text("\(index)").tag(index)
        }
    }
}
