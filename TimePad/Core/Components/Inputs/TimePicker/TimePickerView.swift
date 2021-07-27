//
//  TimePickerView.swift
//  TimePad
//
//  Created by Anday on 23.07.21.
//

import SwiftUI

struct TimePickerView: View {
    var title: String
    @Binding var value: Int
    var lowerBound: Int?
    var upperBound: Int?
    
    var body: some View {
        Picker(selection: $value,
               label: labelView,
               content: {contentView}
        )
        .pickerStyle(MenuPickerStyle())
        .padding()
        .background(Color.theme.accent.cornerRadius(12))
        .accentColor(Color.theme.gradientPurple)
    }
}


extension TimePickerView {
    private var labelView: some View {
        HStack {
            Text(title)
                .font(.title3)
                .foregroundColor(.primary)
            Spacer()
            Text("\(value)")
                .font(.title2)
            
            
            Image(systemName: "chevron.right")
                .font(.subheadline)
                .foregroundColor(.primary)
            
        }
    }
    
    private var contentView: some View {
        ForEach((lowerBound ?? 0)...(upperBound ?? 60), id: \.self) { index in
            Text("\(index)").tag(index)
        }
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(title: "Time Picker", value: .constant(1), lowerBound: 1, upperBound: 60)
            .previewLayout(.sizeThatFits)
            .padding()
        
        TimePickerView(title: "Time Picker", value: .constant(1), lowerBound: 1, upperBound: 60)
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
            
    }
}
