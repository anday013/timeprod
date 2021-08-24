//
//  TaskDataProvider.swift
//  TimePad
//
//  Created by Anday on 17.08.21.
//

import Foundation
import CoreData
import Combine

class TaskDataProvider {
    static let instance = TaskDataProvider()

    
    @Published var allTasks: [Task] = []
    @Published private var taskEntities: [TaskEntity] = []
    
    let cdManager = CoreDataManager.instance
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        entityToModelListeners()
        fetchTasks()
    }
    
    // PRIVATE FUNCTIONS
    private func entityToModelListeners() {
        $taskEntities
            .map { entities -> [Task] in
                return entities.compactMap({CoreDataHelper.convertToTaskModel(taskEntity: $0)})
            }
            .sink(receiveValue: { [weak self] tasks in
                self?.allTasks = tasks
            })
            .store(in: &cancellables)
    }
    
    // PUBLIC FUNCTIONS
    func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            taskEntities = try cdManager.context.fetch(request)
        } catch let error {
            print("Error fetching: \(error)")
        }
    }
    

    
    func deleteTask(task: Task) -> Bool {
        guard let target = taskEntities.first(where: {task.id == $0.id}) else {
            print("Unable to find task with id: \(task.id)")
            return false
        }
        let result = cdManager.delete(object: target)
        fetchTasks()
        return result
    }
    
    
    func addTask(task: Task, allTagEntities: [TagEntity]) -> Bool {
        let _ = CoreDataHelper.convertToTaskEntity(task: task, allTagEntities: allTagEntities)
        let result = cdManager.save()
        fetchTasks()
        return result
    }
    
    func updateTask(oldTaskId: String, newTask: Task) -> Bool {
        let targetEntity = taskEntities.first(where: {$0.id == oldTaskId})
        targetEntity?.id = newTask.id
        targetEntity?.title = newTask.title
        targetEntity?.date = newTask.date
        targetEntity?.durationSeconds = Int64(newTask.durationSeconds)
        targetEntity?.passedSeconds = Int64(newTask.passedSeconds)
        targetEntity?.iconName = newTask.icon.imageName
//        targetEntity?.tags = newTags
//        (newTask.tags?.compactMap({CoreDataHelper.convertToTagEntity(tag: $0)}))?.forEach({targetEntity?.addToTags($0)})
        return cdManager.save()
    }
    
}
