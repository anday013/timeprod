//
//  TaskSheetView.swift
//  TimePad
//
//  Created by Anday on 17.07.21.
//

import SwiftUI
import Combine

struct TaskSheetView: View {
    var task: Task?
    
    @EnvironmentObject var tasksVM: TasksEnvironmentViewModel
    private var progressValue: Float = 0.0
    private var clockTime: String = formatTime(durationSeconds: 0)
    
    init(task: Task?) {
        self.task = task
        self.clockTime = computeClockValue()
        self.progressValue = computeProgressValue()
    }
    
    var body: some View {
        VStack {
            dragger
            
            header
            
            Spacer()
            
            progressBar
            Spacer()

            actionButtons

            Spacer()
        }
        .padding()
    }
    
    func computeClockValue() -> String {
        guard let task = task else { return formatTime(durationSeconds: 0)}
        return formatTime(durationSeconds: task.durationSeconds - task.passedSeconds)
    }
    
    func computeProgressValue() -> Float {
        guard let task = task else { return 0.0}
        return Float(task.passedSeconds) / Float(task.durationSeconds)
    }
}


extension TaskSheetView {
    private var dragger: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.theme.accent)
            .frame(width: 40, height: 4)
            .padding()
    }
    
    private var header: some View {
        HStack(alignment: .top) {
            Text(task?.title ?? "")
                .bold()
                .font(.title)
                .lineLimit(2)
            Spacer()

            VStack {
                ForEach(task?.tags ?? []) { tag in
                    TagView(tag: tag)
                }
            }
        }
        .padding(8)

    }
    
    private var progressBar: some View {
        ProgressBarView(progress: progressValue)
            .overlay(
                Text(clockTime)
                    .font(Font.system(size: Size.computeWidth(40), weight: .bold, design: .default))
            )
    }
    
    private var actionButtons: some View {
        HStack(spacing: Size.computeWidth(95)) {
            CircleButtonView(action: {
                if isEqualTasks(tasksVM.activeTask, task) {
                    tasksVM.activeTask = nil
                }
                else {
                    tasksVM.activeTask = task
                }
             }, label: isEqualTasks(tasksVM.activeTask, task) ? "Pause" : "Start") {
                Image(systemName: isEqualTasks(tasksVM.activeTask, task) ? "pause.fill" : "play.fill")
            }

            CircleButtonView(action: {
                // TODO
            }, label: "Done") {
                Image(systemName: "checkmark.circle.fill")
            }
        }
    }
    func isRunning() -> Bool {
        return tasksVM.activeTask != nil
    }
}


struct TaskSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TaskSheetView(task: dev.task)
            .environmentObject(TasksEnvironmentViewModel())
        
//        TaskSheetView(task: dev.task, taskVM: TasksViewModel())
//            .preferredColorScheme(.dark)
    }
}
