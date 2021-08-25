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
                .hud(isPresented: $tasksVM.showHUD) {
                    Label(tasksVM.titleHUD, systemImage: tasksVM.systemImageHUD)
                }
        }
    }
    func handlePhaseChange(_ phase: ScenePhase) {
        if phase == .active {
            guard let startDate = fetchFrozenTimer(),
                  let _ = tasksVM.activeTask else {return}
            tasksVM.activeTask?.passedSeconds -= Int(startDate.timeIntervalSinceNow)
            
            if isEqualTasks(tasksVM.activeTask, tasksVM.selectedTask) {
                tasksVM.selectedTask = tasksVM.activeTask
            }
        } else if phase == .background {
            guard let _ = tasksVM.activeTask else {
                removeFrozenTimer()
                return
            }
            saveFrozenTimer()
        } else if phase == .inactive {
            // SYNCHRONISE CORE DATA
            tasksVM.synchroniseTasks()
        }
    }
}
