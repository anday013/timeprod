//
//  StatsViewModel.swift
//  TimePad
//
//  Created by Anday on 11.08.21.
//

import Foundation
import Combine

class StatsViewModel: ObservableObject {
    var tasksVM: TasksEnvironmentViewModel?
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    var currentDate: Date = Date()
    
    @Published var lastWeekTasks: [Task] = []
    
    @Published var dailyCompletedTasks: [Task] = []
    @Published var weeklyCompletedTasks: [(Int, [Task])] = []
    @Published var selectedTab: StatsTab = .day
    
    @Published var productiveSeconds: Int = 0
    @Published var dailyProductiveMinutes: [Int] = []
    
    
    
    init(tasksVM: TasksEnvironmentViewModel?) {
        self.tasksVM = tasksVM
    }
    
    func update(tasksVM: TasksEnvironmentViewModel) {
        self.tasksVM = tasksVM
        self.dailyCompletedTasks = self.findDailyCompletedTasks()
        self.lastWeekTasks = self.findLastWeekTasks()
        self.weeklyCompletedTasks = self.findWeeklyCompletedTasks(tasks: lastWeekTasks)
        self.updateProductiveSeconds()
        self.dailyProductiveMinutes = self.computeDailyProductiveHoursGraphStats(tasks: self.tasksVM?.todaysTasks ?? [])
    }
    
    private func findDailyCompletedTasks() -> [Task] {
        return self.tasksVM?.todaysTasks.compactMap { task in
            if task.passedSeconds >= task.durationSeconds {
                return task
            }
            return nil
        } ?? []
    }
    
    private func findLastWeekTasks() -> [Task] {
        var lastWeekTasks: [Task] = []
        for dayNumber in currentDate.last7days {
            for task in tasksVM?.tasks.sorted(by: {$0.date.compare($1.date) == .orderedDescending}) ?? [] {
                if task.date.day == dayNumber && task.date.month == currentDate.month && task.date.year == currentDate.year {
                    lastWeekTasks.append(task)
                }
            }
        }
        return lastWeekTasks
    }
    
    
    private func findWeeklyCompletedTasks(tasks: [Task]) -> [(Int, [Task])] {
        let orderedTasks = tasks.sorted(by: {$0.date.compare($1.date) == .orderedDescending})
        var lastWeekTasks: [[Task]] = Array(repeating: [], count: 7)
        
        for (index, dayNumber) in currentDate.last7days.enumerated() {
            for task in orderedTasks {
                if task.date.day == dayNumber && task.date.month == currentDate.month && task.date.year == currentDate.year {
                    lastWeekTasks[index].append(task)
                }
            }
        }
        
        return lastWeekTasks.enumerated().compactMap { (idx, tasks) -> (Int,[Task]) in
            return (currentDate.last7days[idx],tasks.compactMap { task -> Task? in
                if task.passedSeconds >= task.durationSeconds {
                    return task
                }
                return nil
            })
        }
    }
    
    private func updateProductiveSeconds() {
        $selectedTab
            .sink { [weak self] selectedTab in
                guard let self = self else {return}
                self.productiveSeconds = self.computeProductiveSeconds(tasks: selectedTab == .day ? self.tasksVM?.todaysTasks ?? [] : self.lastWeekTasks)
            }
            .store(in: &cancellables)
    }
    
    func computeProductiveSeconds(tasks: [Task]) -> Int {
        return tasks.map { task -> Int in
            return task.passedSeconds
        }.reduce(0, +)
    }
    
    func countDailyCompletedTasks() -> Int {
        return self.dailyCompletedTasks.count
    }
    
    func countWeeklyCompletedTasks() -> Int {
        return self.weeklyCompletedTasks
            .compactMap { taskTuple -> Int in
                return taskTuple.1.count
            }
            .reduce(0, +)
    }
    
    
    func computeDailyProductiveHoursGraphStats(tasks: [Task]) -> [Int] {
        let hoursInDay = 24
        let minutesInHour = 60
        var prodMinutesPerHour: [Int] = Array(repeating: 0, count: hoursInDay)
        for task in tasks {
            let hour = task.date.hour
            let prodMinutes = Int(floor(Double(task.passedSeconds / Constants.secondsInMinutes)))
            let prodHours = Int(floor(Double(prodMinutes / minutesInHour)))
            
            guard prodHours > 0 else { continue }
            
            for i in 0...prodHours-1 {
                if hour + i < hoursInDay {
                    prodMinutesPerHour[hour + i] = minutesInHour
                }
            }
            
            let extraMinutes = prodMinutes % minutesInHour
            if hour + prodHours < hoursInDay && extraMinutes != 0  {
                if prodMinutesPerHour[hour + prodHours] + extraMinutes > minutesInHour {
                    prodMinutesPerHour[hour + prodHours] = minutesInHour
                } else {
                    prodMinutesPerHour[hour + prodHours] += extraMinutes
                }
            }
        }
        return prodMinutesPerHour
    }
    
    func generateDailyGraphValues(productiveMinutesPerHour: [Int]) -> [(String, Int)] {
        return productiveMinutesPerHour.enumerated().map { (index, minute) -> (String, Int) in
            if index == 0 {
                return ("12 am", minute)
            }
            if index < 12 {
                return ("\(index) am",minute)
            }
            if index > 12 {
                return ("\(index - 12) pm", minute)
            }
            // index == 12
            return ("12 pm", minute)
        }
    }
    
    
    
}

enum StatsTab: String, CaseIterable {
    case day = "Day"
    case week = "Week"
}
