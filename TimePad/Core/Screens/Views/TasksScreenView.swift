//
//  Tasks.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import SwiftUI

struct TasksScreenView: View {
    @EnvironmentObject var tasksVM: TasksEnvironmentViewModel
    
    var body: some View {
        VStack {
            activeTaskBox
            
            HStack {
                Text("Today")
                    .font(.title)
                    .bold()
                Spacer()
                
            }
            .padding(.top, 32)
            .padding(.bottom, 16)
            
            taskList
        }
        .sheet(item: $tasksVM.selectedTask) { task in
            TaskSheetView(task: task)
                .environmentObject(tasksVM.self)
        }
        .padding()
    }
    
    func setSelectedTask(task: Task?) {
        tasksVM.selectedTask = task
    }
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                TasksScreenView()
                    .navigationTitle("Task")
            }
            
//            NavigationView {
//                TasksScreenView()
//                    .preferredColorScheme(.dark)
//                    .navigationTitle("Task")
//            }
            
        }
        .environmentObject(TasksEnvironmentViewModel())
    }
    
}


extension TasksScreenView {
    private var activeTaskBox: some View {
        Button(action: {
            setSelectedTask(task: tasksVM.activeTask)
        }) {
            CurrentTaskView(task: tasksVM.activeTask)
                .foregroundColor(.primary)
        }
    }
    
    private var taskList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(tasksVM.todaysTasks) { task in
                    Button(action: {
                        setSelectedTask(task: task)
                    }) {
                        TaskView(task: task)
                            .foregroundColor(.primary)
                    }
                    
                }
            }
        }
    }
}
