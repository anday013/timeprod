//
//  TimeStepperView.swift
//  TimePad
//
//  Created by Anday on 23.07.21.
//

import SwiftUI

struct TimeStepperView: View {
    var title: String
    @Binding var value: Int
    var lowerBound: Int?
    var upperBound: Int?
    
    var body: some View {
        Stepper(
            onIncrement: {
                guard let upperBound = upperBound else {
                    value += 1
                    return
                }
                if(value < upperBound){
                    value += 1
                }
            },
            onDecrement: {
                guard let lowerBound = lowerBound else {
                    value -= 1
                    return
                }
                if(value > lowerBound){
                    value -= 1
                }
            },
            label: {
                HStack {
                    Text(title)
                        .font(.title3)
                    Spacer()
                    Text("\(value)")
                        .font(.title2)
                        .padding(.horizontal)
                        .foregroundColor(Color.theme.gradientPurple)
                }
                
            })
            .padding()
            .background(Color.theme.accent.cornerRadius(12))
            .accentColor(Color.theme.gradientPurple)
    }
}


struct TimeStepperView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStepperView(title: "Time Stepper", value: .constant(1), lowerBound: 1, upperBound: 24)
            .previewLayout(.sizeThatFits)
            .padding()
        
        TimeStepperView(title: "Time Stepper", value: .constant(1), lowerBound: 1, upperBound: 24)
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
            
    }
}
