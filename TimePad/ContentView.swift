//
//  ContentView.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: BottomBarRouter
    var body: some View {
        VStack{
            Spacer()
            NavigationView {
                switch viewRouter.currentPage {
                case .tasks:
                    TasksScreenView()
                        .navigationTitle("Task")
                case .add:
                    AddTaskScreenView()
                        .navigationTitle("New Task 🔖")
                case .stats:
                    StatsScreenView()
                        .navigationTitle("My Productivity 🏃‍♂️")
                }
            }
            .accentColor(.primary)
            Spacer()
            BottomBarView()
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(BottomBarRouter())
            .environmentObject(TasksEnvironmentViewModel())
    }
}
