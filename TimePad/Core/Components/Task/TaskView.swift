//
//  TaskView.swift
//  TimePad
//
//  Created by Anday on 15.07.21.
//

import SwiftUI

struct TaskView: View {
    let task: Task
    let formattedTime: String
    
    init(task: Task) {
        self.task = task
        formattedTime = formatTime(hours: task.durationHours, minutes: task.durationMinutes, seconds: task.durationSeconds)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(Color(hex: task.backgroundColor))
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .lineLimit(1)
                HStack {
                    ForEach(task.tags ?? []) { tag in
                       TagView(tag: tag)
                    }
                }
                
            }
            
            Spacer()
            VStack(alignment: .trailing ,spacing: 8) {
                Text(formattedTime)
                Image(systemName: "play.fill")
                    .foregroundColor(.gray)
                    .font(.title2)
            }
        }
        .padding()
        .background(Color.theme.primary)
        .cornerRadius(12)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: Task(title: "Learn IOS", durationHours: 2, durationMinutes: 0, durationSeconds: 0, icon: "monitor", backgroundColor: "9B51E0", tags: [Tag(name: "Work", fontColor: "FD5B71"), Tag(name: "Coding", fontColor: "FD5B71")]))
            .previewLayout(.sizeThatFits)
            .padding()
        
        TaskView(task: Task(title: "Learn IOS", durationHours: 2, durationMinutes: 0, durationSeconds: 0, icon: "monitor", backgroundColor: "9B51E0", tags: [Tag(name: "Work", fontColor: "FD5B71"), Tag(name: "Coding", fontColor: "FD5B71")]))
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
    }
}
