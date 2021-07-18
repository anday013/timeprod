//
//  MainButtonView.swift
//  TimePad
//
//  Created by Anday on 18.07.21.
//

import SwiftUI

struct MainButtonView: View {
    var action: () -> Void
    var label: String
    var transparent: Bool = false
    var body: some View {
        Button(action: action, label: {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: Size.computeWidth(295), height: Size.computeHeight(60))
                .foregroundColor(transparent ? Color(UIColor.systemBackground) :.accentColor)
                .overlay(
                    Text(label)
                        .bold()
                        .font(.title2)
                        .foregroundColor(.primary)
                )
        })
        

    }
}

struct MainButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonView(action: {}, label: "Finish")
            .previewLayout(.sizeThatFits)
            .padding()
        
        MainButtonView(action: {}, label: "Finish", transparent: true)
            .previewLayout(.sizeThatFits)
            .padding()
     
        MainButtonView(action: {}, label: "Quit")
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
        
        MainButtonView(action: {}, label: "Quit", transparent: true)
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
    }
}
