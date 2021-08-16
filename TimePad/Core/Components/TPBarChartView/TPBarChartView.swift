//
//  TPBarChartView.swift
//  TimePad
//
//  Created by Anday on 16.08.21.
//

import SwiftUI
import SwiftUICharts

struct TPBarChartView: View {
    var data: ChartData
    var body: some View {
        BarChartView(
            data: data,
            title: "",
            style: .init(
                backgroundColor: Color.theme.accent,
                accentColor: .theme.gradientPurple,
                gradientColor: GradientColor(start: .theme.gradientPurple , end: .theme.gradientPurple.opacity(0.5)),
                textColor: .primary,
                legendTextColor: .primary,
                dropShadowColor: .primary
            ),
            form: ChartForm.extraLarge,
            dropShadow: false,
            cornerImage: nil,
            valueSpecifier: "%.0f",
            animatedToBack: true
        )
    }
}

struct TPBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        TPBarChartView(data: ChartData(values: [("12am",1),("12am",0),("12am",1), ("12am",1), ("12am",2)]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
