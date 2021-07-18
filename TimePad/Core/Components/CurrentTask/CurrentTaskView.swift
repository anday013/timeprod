//
//  CurrentTaskView.swift
//  TimePad
//
//  Created by Anday on 17.07.21.
//

import SwiftUI

struct CurrentTaskView: View {
    var title: String
    var timeline: String
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text(timeline)
                    .font(.title)
                    .bold()
                Spacer()
                Image(systemName: "chevron.right")
            }
            HStack(spacing: 12) {
                Circle()
                    .strokeBorder(RadialGradient(gradient: Gradient(colors: [Color.white, Color.theme.gradientPurple]), center: .topTrailing, startRadius: 2, endRadius: 20), lineWidth: 2)
                    .frame(width: 16, height: 16)
                
                Text(title)
                    .font(.callout)
                Spacer()
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .background(Color.theme.accent)
        .cornerRadius(12)
    }
}

struct CurrentTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentTaskView(title: "SwiftUI Project", timeline: "00:32:10")
            .previewLayout(.sizeThatFits)
            .padding()
        CurrentTaskView(title: "SwiftUI Project", timeline: "00:32:10")
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
    }
}
