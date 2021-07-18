//
//  Tasks.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import SwiftUI

struct Tasks: View {
    @StateObject var vm: TasksViewModel = TasksViewModel()
    var body: some View {
        VStack {
            CurrentTaskView(title: "SwiftUI Project", timeline: "00:32:10")
            
            
            HStack {
                Text("Today")
                    .font(.title)
                    .bold()
                Spacer()
                
                Text("See All")
                    .font(.title3)
            }
            .padding(.top, 32)
            .padding(.bottom, 16)
            
            
            
            
            ScrollView {
                ForEach(vm.tasks) { task in
                    Button(action: {
                        vm.selectedTask = task
                    }, label: {
                        TaskView(task: task)
                            .foregroundColor(.primary)
                    })
                }
            }
        }
        .sheet(item: $vm.selectedTask, content: { task in
            TaskSheetView(task: task)
        })
        .padding()
        
    }
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Tasks()
                .navigationTitle("Task")
        }
        
        NavigationView {
            Tasks()
                .preferredColorScheme(.dark)
                .navigationTitle("Task")
        }
        
        
    }
}
