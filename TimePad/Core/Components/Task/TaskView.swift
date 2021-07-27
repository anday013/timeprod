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
        formattedTime = formatTime(durationSeconds: task.durationSeconds - task.passedSeconds)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            IconView(icon: task.icon)
            
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
        TaskView(task: dev.task)
            .previewLayout(.sizeThatFits)
            .padding()
        
        TaskView(task: dev.task)
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
    }
}
