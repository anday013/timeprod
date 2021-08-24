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
    
    // DATA PROVIDERS
    let taskDP = TaskDataProvider.instance
    let tagDP = TagDataProvider.instance
    
    @Published var canellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        icons = Constants.icons
        _DPListeners()
        setupTimer()
        addTaskSubscriber(taskListener: $activeTask)
        sortTasks()
    }
    
    // PUBLIC FUNCTIONS
    func addTask(_ task: Task) {
        let _ = taskDP.addTask(task: task, allTagEntities: tagDP.getAllTagEntities())
    }
    
    func deleteTask(_ task: Task) {
        let _ = taskDP.deleteTask(task: task)
    }
    
    func addTag(_ tag: Tag) {
        let _ = tagDP.addTag(tag: tag)
    }
    
    func deleteTag(_ tag: Tag){
        let _ = tagDP.deleteTag(tag: tag)
    }
    
    func synchroniseTasks(){
        tasks.forEach { let _ = taskDP.updateTask(oldTaskId: $0.id, newTask: $0) }
    }
    
    // PRIVATE FUNCS
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
    
    private func _DPListeners() {
        taskDP.$allTasks
            .combineLatest(tagDP.$allTags)
            .sink { [weak self] tasks,tags in
                self?.tasks = tasks
                self?.tags = tags
            }
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
}
