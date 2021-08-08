//
//  CurrentTaskView.swift
//  TimePad
//
//  Created by Anday on 17.07.21.
//

import SwiftUI

struct CurrentTaskView: View {
    var task: Task?
    @EnvironmentObject var tasksVM: TasksEnvironmentViewModel
    private var timeline: String = formatTime(durationSeconds: 0)
    
    init(task: Task?) {
        self.task = task
        self.timeline = computeTimeline()
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text(timeline)
                    .bold()
                    .font(.title)
                Spacer()
                Image(systemName: "chevron.right")
            }
            HStack(spacing: 12) {
                Circle()
                    .strokeBorder(RadialGradient(gradient: Gradient(colors: [Color.white, Color.theme.gradientPurple]), center: .topTrailing, startRadius: 2, endRadius: 20), lineWidth: 2)
                    .frame(width: 16, height: 16)
                
                Text(task?.title ?? "Choose task to start...🔖")
                    .font(.callout)
                Spacer()
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .background(Color.theme.accent)
        .cornerRadius(12)
    }
    
    func computeTimeline() -> String {
        guard let task = task else {return formatTime(durationSeconds: 0)}
        return formatTime(durationSeconds: task.durationSeconds - task.passedSeconds)
        
    }
}

struct CurrentTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentTaskView(task: dev.task)
            .previewLayout(.sizeThatFits)
            .padding()
        CurrentTaskView(task: dev.task)
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
    }
}
