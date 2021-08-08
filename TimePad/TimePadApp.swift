//
//  TimePadApp.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import SwiftUI

@main
struct TimePadApp: App {
    @StateObject var viewRouter:BottomBarRouter = BottomBarRouter()
    @StateObject var tasksVM: TasksEnvironmentViewModel = TasksEnvironmentViewModel()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
                .environmentObject(tasksVM)
                .onChange(of: scenePhase, perform: handlePhaseChange)
                
        }
    }
    func handlePhaseChange(_ phase: ScenePhase) {
        if phase == .active {
            guard let startDate = fetchFrozenTimer(),
                  let _ = tasksVM.activeTask else {return}
            tasksVM.activeTask?.passedSeconds -= Int(startDate.timeIntervalSinceNow)
        } else if phase == .background {
            guard let _ = tasksVM.activeTask else {
                removeFrozenTimer()
                return
            }
            saveFrozenTimer()
        }
    }
}
