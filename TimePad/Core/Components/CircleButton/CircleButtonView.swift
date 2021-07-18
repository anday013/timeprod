//
//  CircleButtonView.swift
//  TimePad
//
//  Created by Anday on 17.07.21.
//

import SwiftUI

struct CircleButtonView<Content: View>: View {
    var content: () -> Content
    var action: () -> Void
    var label: String?
    
    init(
        action: @escaping () -> Void,
         label: String?,
         @ViewBuilder content: @escaping () -> Content
    ) {
        self.action = action
        self.label = label
        self.content = content
    }
    
    var body: some View {
        VStack {
            Button(action: action, label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color.theme.accent)
                    
                    content()
                        .foregroundColor(Color.theme.gray)
                        .font(.title2)
                }
                .frame(width: 60, height: 60)
            })
            
            if(label != nil && label != ""){
                Text(label ?? "")
            }
        }
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(action: {}, label: "Pause") {
                Image(systemName: "pause.fill")
            }
            .previewLayout(.sizeThatFits)
            .padding()
        CircleButtonView(action: {}, label: "")  {
                Image(systemName: "stop.fill")
            }
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
            
    }
}
