//
//  TaskSheetView.swift
//  TimePad
//
//  Created by Anday on 17.07.21.
//

import SwiftUI

struct TaskSheetView: View {
    var task: Task
    @State private var progressValue: Float = 0.6
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.theme.accent)
                .frame(width: 40, height: 4)
                .padding()
            
            HStack(alignment: .top) {
                Text(task.title)
                    .bold()
                    .font(.title)
                Spacer()
                
                VStack {
                    ForEach(task.tags ?? []) { tag in
                        TagView(tag: tag)
                    }
                }
            }
            .padding(8)
            Spacer()
            
            
            
            ProgressBarView(progress: $progressValue)
                .overlay(
                    Text(formatTime(hours: task.durationHours, minutes: task.durationMinutes, seconds: task.durationSeconds))
                            .font(Font.system(size: 40, weight: .bold, design: .default))
                )
            
            Spacer()
            
            HStack(spacing: Size.computeWidth(95)) {
                CircleButtonView(action: {}, label: "Pause") {
                    Image(systemName: "pause.fill")
                }
                
                CircleButtonView(action: {}, label: "Done") {
                    Image(systemName: "checkmark.circle.fill")
                }
//

            }
            
            Spacer()
//            MainButtonView(action: {}, label: "Finish")
//
//
//            MainButtonView(action: {}, label: "Quit", transparent: true)
//
            
           
            
            
        }
        .padding()
    }
}

struct ProgressBarView: View {
    @Binding var progress: Float
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
        TaskSheetView(task: Task(title: "Learn IOS", durationHours: 2, durationMinutes: 0, durationSeconds: 0, icon: "monitor", backgroundColor: "9B51E0", tags: [Tag(name: "Work", fontColor: "FD5B71"), Tag(name: "Coding", fontColor: "FD5B71")]))
        
//        TaskSheetView(task: Task(title: "Learn IOS", durationHours: 2, durationMinutes: 0, durationSeconds: 0, icon: "monitor", backgroundColor: "9B51E0", tags: [Tag(name: "Work", fontColor: "FD5B71"), Tag(name: "Coding", fontColor: "FD5B71")]))
//            .preferredColorScheme(.dark)
    }
}
