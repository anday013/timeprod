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
        print("INIT: Sheet")
        self.task = task
        self.clockTime = computeClockValue()
        self.progressValue = computeProgressValue()
        print("ClockTime: \(self.clockTime)")
        print("ProgressValue: \(self.progressValue)")
    }
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.theme.accent)
                .frame(width: 40, height: 4)
                .padding()
            
            HStack(alignment: .top) {
                Text(task?.title ?? "")
                    .bold()
                    .font(.title)
                Spacer()

                VStack {
                    ForEach(task?.tags ?? []) { tag in
                        TagView(tag: tag)
                    }
                }
            }
            .padding(8)
            Spacer()
            


            ProgressBarView(progress: progressValue)
                .overlay(
                    Text(clockTime)
                        .font(Font.system(size: Size.computeWidth(40), weight: .bold, design: .default))
                )
            Spacer()

            HStack(spacing: Size.computeWidth(95)) {
                CircleButtonView(action: {
                    if(tasksVM.activeTask?.id == task?.id){
                        tasksVM.activeTask = nil
                    }
                    else {
                        tasksVM.activeTask = task
                    }
                 }, label: tasksVM.activeTask?.id == task?.id ? "Pause" : "Start") {
                    Image(systemName: tasksVM.activeTask?.id == task?.id ? "pause.fill" : "play.fill")
                }

                CircleButtonView(action: {

                }, label: "Done") {
                    Image(systemName: "checkmark.circle.fill")
                }
            }

            Spacer()
        }
        .padding()
    }
    
    func computeClockValue() -> String {
        guard let task = task else { return formatTime(durationSeconds: 0)}
        print("Compute Clock Value")
        return formatTime(durationSeconds: task.durationSeconds - task.passedSeconds)
    }
    
    func computeProgressValue() -> Float {
        guard let task = task else { return 0.0}
        return Float(task.passedSeconds) / Float(task.durationSeconds)
    }
}

struct ProgressBarView: View {
    var progress: Float
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 25)
                .foregroundColor(Color.theme.accent)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineCap: .round, lineJoin: .round))
                .stroke(RadialGradient(gradient: Gradient(colors: [Color.white, Color.theme.gradientPurple]), center: .topTrailing, startRadius: 10, endRadius: 200), lineWidth: 25)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
                
        }.frame(width: Size.computeWidth(220), height: Size.computeWidth(220))
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
