//
//  ProgressBarView.swift
//  TimePad
//
//  Created by Anday on 05.08.21.
//

import SwiftUI

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

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progress: 0.2)
    }
}
