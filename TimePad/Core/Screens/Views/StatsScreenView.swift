//
//  StatsScreenView.swift
//  TimePad
//
//  Created by Anday on 01.08.21.
//

import SwiftUI

import SwiftUICharts

struct StatsScreenView: View {
    @EnvironmentObject var tasksVM: TasksEnvironmentViewModel
    @StateObject private var vm: StatsViewModel = StatsViewModel(tasksVM: nil)
    
    init() {
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.theme.accent)
    }
    
    var body: some View {
        ScrollView {
            VStack{
                PanelsView
                CustomPickerView
                if vm.selectedTab == .day
                {
                    TPBarChartView(data: ChartData(values: vm.generateDailyGraphValues(productiveMinutesPerHour: vm.dailyProductiveMinutes)))
                        .padding()
                        .transition(.move(edge: .trailing))
                        .animation(.spring())
                }
                else {
                    TPBarChartView(data: ChartData(values: generateGraphValues()))
                        .padding()
                        .transition(.move(edge: .leading))
                        .animation(.spring())
                }
                Spacer()
            }
        }
        .onAppear {
            vm.update(tasksVM: tasksVM)
        }
        
    }
    
    func generateGraphValues() -> [(String, Int)] {
        return vm.weeklyCompletedTasks.map({("\($0)", vm.computeProductiveSeconds(tasks: $1))})
    }
}


extension StatsScreenView {
    
    private var PanelsView: some View {
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
                let textValue = "\(vm.selectedTab == .day ? vm.countDailyCompletedTasks() : vm.countWeeklyCompletedTasks())"
                Text(textValue)
                    .bold()
                    .font(.largeTitle)
                    .transition(.opacity.animation(.easeInOut))
                    .id("AnimatedTaskText" + textValue)
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
                    let hourValue = "\(Int(floor(Double(vm.productiveSeconds / Constants.secondsInHour))))"
                    Text(hourValue)
                        .bold()
                        .font(.largeTitle)
                        .id("AnimatedHourText" + hourValue)
                        .transition(.opacity.animation(.easeInOut))
                    
                    Text("h ")
                        .font(.title3)
                        .foregroundColor(.primary.opacity(0.6))
                        .id("AnimatedHourText" + hourValue)
                        .transition(.opacity.animation(.easeInOut))

                    
                    let minuteValue = "\(Int((vm.productiveSeconds % Constants.secondsInHour) / Constants.secondsInMinutes))"
                    Text(minuteValue)
                        .bold()
                        .font(.largeTitle)
                        .id("AnimatedMinuteText" + minuteValue)
                        .transition(.opacity.animation(.easeInOut))
                    
                    Text("m")
                        .font(.title3)
                        .foregroundColor(.primary.opacity(0.6))
                        .id("AnimatedMinuteText" + minuteValue)
                        .transition(.opacity.animation(.easeInOut))
                }
            }
            .padding()
            .background(Color.theme.primary.cornerRadius(12))
        }
        .padding()
    }
    
    private var CustomPickerView: some View {
        Picker("", selection: $vm.selectedTab) {
            ForEach(StatsTab.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .frame(width: Size.computeWidth(279 / 1.5))
        .pickerStyle(SegmentedPickerStyle())
        .scaledToFit()
        .scaleEffect(CGSize(width: 1.22, height: 1.22))
        .padding(.top, 24)
        .padding(.bottom, 8)
    }
}



struct StatsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StatsScreenView()
                .navigationTitle("My Productivity 🏃‍♂️")
                .environmentObject(TasksEnvironmentViewModel())
        }
        
        //        NavigationView {
        //            StatsScreenView()
        //                .navigationTitle("My Productivity 🏃‍♂️")
        //                .preferredColorScheme(.dark)
        //                .environmentObject(TasksEnvironmentViewModel())
        //        }
        
    }
}
