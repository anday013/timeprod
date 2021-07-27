//
//  IconVIew.swift
//  TimePad
//
//  Created by Anday on 25.07.21.
//

import SwiftUI

struct IconView: View {
    var icon: Icon
    var body: some View {
        Circle()
            .fill(Color(hex: icon.backgroundColor))
            .overlay(
                Image(icon.imageName)
            )
            .frame(width: Size.computeWidth(44), height: Size.computeWidth(44))
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(icon: dev.task.icon)
            .previewLayout(.sizeThatFits)
            .padding()
        
        
        IconView(icon: dev.task.icon)
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
            
    }
}
