//
//  StatsScreenView.swift
//  TimePad
//
//  Created by Anday on 01.08.21.
//

import SwiftUI

import SwiftUICharts

struct StatsScreenView: View {
    var body: some View {
        ScrollView {
            VStack{
                
                panelsView2
                .padding()
                
                LineView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", style: .init(backgroundColor: Color.theme.accent, accentColor: .theme.gradientPurple, gradientColor: GradientColor(start: .theme.gradientPurple , end: .white), textColor: .primary, legendTextColor: .primary, dropShadowColor: .primary))
                    .padding()

                
                
                
                Spacer()
                
                
            }
        }
        
    }
}


extension StatsScreenView {
    
    private var panelsView2: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    Image("Stats_task_icon")
                        .resizable()
                        .frame(width: Size.computeWidth(32), height: Size.computeWidth(32))
                    VStack(alignment: .leading) {
                        Text("Task").lineLimit(1)
                        Text("Completed").lineLimit(1)
                    }
                    Spacer()
                }
                
                Text("12")
                    .bold()
                    .font(.largeTitle)
            }
            .padding()
            .background(Color.theme.primary.cornerRadius(12))
            
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    Image("Stats_time_icon")
                        .resizable()
                        .frame(width: Size.computeWidth(32), height: Size.computeWidth(32))
                    VStack(alignment: .leading) {
                        Text("Time").lineLimit(1)
                        Text("Duration").lineLimit(1)
                    }
                    Spacer()
                }
                
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("1")
                        .bold()
                        .font(.largeTitle)
                    
                    Text("h ")
                        .font(.title3)
                        .foregroundColor(.primary.opacity(0.6))
                        
                    
                    Text("46")
                        .bold()
                        .font(.largeTitle)
                    
                    Text("m")
                        .font(.title3)
                        .foregroundColor(.primary.opacity(0.6))
                }
            }
            .padding()
            .background(Color.theme.primary.cornerRadius(12))
        }
    }
}





struct StatsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StatsScreenView()
                .navigationTitle("My Productivity 🏃‍♂️")
        }
        
        NavigationView {
            StatsScreenView()
                .navigationTitle("My Productivity 🏃‍♂️")
                .preferredColorScheme(.dark)
        }
        
    }
}
