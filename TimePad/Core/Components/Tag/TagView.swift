//
//  TagView.swift
//  TimePad
//
//  Created by Anday on 17.07.21.
//

import SwiftUI

struct TagView: View {
    var tag: Tag
    var body: some View {
        Text(tag.name)
            .font(.subheadline)
            .lineLimit(1)
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .foregroundColor(Color(hex: tag.fontColor))
            .background(Color(hex: tag.fontColor).opacity(0.1).cornerRadius(6))
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: Tag(name: "Work", fontColor: "#FD5B71"))
            .previewLayout(.sizeThatFits)
            .padding()
        
        TagView(tag: Tag(name: "Work", fontColor: "#FD5B71"))
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
            
    }
}
