//
//  TasksViewModel.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import Foundation
import Combine

class TasksEnvironmentViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var todaysTasks: [Task] = []
    @Published var selectedTask: Task? = nil
    @Published var activeTask: Task? = nil
    @Published var tags: [Tag] = []
    @Published var icons: [Icon] = []
    
    @Published var canellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        tags = [
            Tag(name: "Work", fontColor: "FD5B71"),
            Tag(name: "Coding", fontColor: "FD5B71"),
            Tag(name: "Workout", fontColor: "FFA656"),
            Tag(name: "Reading", fontColor: "07E092"),
        ]
        
        icons = [
            Icon(imageName: "monitor", backgroundColor: "9B51E0"),
            Icon(imageName: "book", backgroundColor: "07E092"),
            Icon(imageName: "code", backgroundColor: "FD5B71")
            
        ]
        
        

        tasks = [
            Task(title: "Learn IOS", date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(),durationSeconds: 7200,passedSeconds: 7200, icon: icons[0], tags: []),
            Task(title: "Learn IOS", date:  Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),durationSeconds: 7200,passedSeconds: 7200, icon: icons[0], tags: []),
            Task(title: "Learn IOS", date:  Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(),durationSeconds: 7200,passedSeconds: 5000, icon: icons[0], tags: []),
            Task(title: "Learn IOS", date:  Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),durationSeconds: 7200,passedSeconds: 5000, icon: icons[0], tags: []),
            Task(title: "Learn IOS", date:  Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),durationSeconds: 7200,passedSeconds: 5000, icon: icons[0], tags: []),
            Task(title: "Read 10 pages of book", date: Date() + 5, durationSeconds: 3600, passedSeconds: 3600, icon: icons[1], tags: []),
            Task(title: "Learn HTML & CSS", date: Date(), durationSeconds: 10, icon: icons[2], tags: [tags[2]])
        ]
        
        setupTimer()
        addTaskSubscriber(taskListener: $activeTask)
        sortTasks()
    }
    
    private func setupTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _tasks in
                guard let self = self else {return}
                self.updateActiveTaskTime(seconds: 1)
            })
            .store(in: &canellables)
    }
    
    private func sortTasks() {
        $tasks
            .map({ tasks -> [Task] in
                return self.filterTodaysTasks(tasks: tasks).sorted(by: {$0.date.compare($1.date) == .orderedDescending})
            })
            .sink { [weak self] orderedTasks in
                self?.todaysTasks = orderedTasks
            }
            .store(in: &canellables)
    }
    
    // Update tasks array each time when activeTask get updated
    private func addTaskSubscriber(taskListener: Published<Task?>.Publisher) {
        taskListener
            .sink(receiveValue: { [weak self] task in
                guard let task = task else {return}
                if let activeTaskIndex = self?.tasks.firstIndex(where: { isEqualTasks($0, task)}) {
                    self?.tasks[activeTaskIndex] = task
                }
            })
            .store(in: &canellables)
        
    }
    
    private func updateActiveTaskTime(seconds: Int) {
        guard let activeTask = self.activeTask,
              activeTask.passedSeconds < activeTask.durationSeconds else {return}
        self.activeTask?.passedSeconds += seconds
        guard let selectedTask = self.selectedTask,
              isEqualTasks(selectedTask, self.activeTask) else {return}
        self.selectedTask?.passedSeconds += seconds
        
    }
    
    
    private func filterTodaysTasks(tasks: [Task]) -> [Task] {
        return tasks.filter { task in
            let currentDate = Date()
            
            let today = currentDate.day
            let currentMonth = currentDate.month
            let currentYear = currentDate.year
            
            let taskDay = task.date.day
            let taskMonth = task.date.month
            let taskYear = task.date.year

            if taskDay == today && taskMonth == currentMonth && taskYear == currentYear {
                return true
            }
            return false

        }
    }
    
    
    // PUBLIC FUNCTIONS
    func addTask(_ task: Task) {
        tasks.append(task)
    }
}
