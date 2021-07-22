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
                        .navigationBarHidden(true)
                case .add:
                    AddTaskScreenView()
                        .navigationTitle("New Task 🔖")
                case .stats:
                    Text("Stats")
                }
            }
            Spacer()
            BottomBarView()
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BottomBarRouter())
            .environmentObject(TasksEnvironmentViewModel())
    }
}
