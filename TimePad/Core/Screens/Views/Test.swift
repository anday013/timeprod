//
//  Test.swift
//  TimePad
//
//  Created by Anday on 30.07.21.
//

import SwiftUI

import CoreData
import Combine

class TestViewModel: ObservableObject {
    let cdManager = CoreDataManager.instance
    @Published var tasks: [TaskEntity] = []
    @Published var tags: [TagEntity] = []
    @Published var tasksModels: [Task] = []
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
//        let icons = [
//            Icon(imageName: "monitor", backgroundColor: "9B51E0")
//        ]
        
        let tags = [
            Tag(name: "Work", fontColor: "FD5B71"),
            Tag(name: "Coding", fontColor: "FD5B71"),
            Tag(name: "Workout", fontColor: "FFA656"),
            Tag(name: "Reading", fontColor: "07E092"),
        ]
        tags.forEach { tag in
            TagDataProvider.instance.addTag(tag: tag)
        }
//        CoreDataHelper.convertToTaskEntity(task: Task(title: "Test", date: Date(), durationSeconds: 120, icon: icons[0], tags: [tags[0], tags[1]]), allTagEntities: TagDataProvider.instance.getAllTagEntites())
//        CoreDataHelper.convertToTaskEntity(task: Task(title: "Test1", date: Date(), durationSeconds: 120, icon: icons[0], tags: [tags[0], tags[1]]), allTagEntities: TagDataProvider.instance.getAllTagEntites())
//        CoreDataManager.instance.save()

//        fetchTags()
//
//        performAdd()
//        fetchTasks()
//
//
//        $tasks
//            .map { taskEntities -> [Task] in
//            var t: [Task] = []
//            for te in taskEntities {
//                t.append(Task(id: te.id ?? UUID().uuidString, title: te.title ?? "", date: te.date ?? Date(), durationSeconds: Int(te.durationSeconds), passedSeconds: Int(te.passedSeconds), icon: icons.first(where: {$0.imageName == te.iconName}) ?? icons[0],
//                              tags: (te.tags?.allObjects as? [TagEntity])?.map({ tagEntity -> Tag in
//                                return self.convertTagEntity(tagEntity: tagEntity)
//                              })
//                ))
//
//                print(t)
//            }
//            return t
//            }
//            .sink { allTasks in
//                self.tasksModels = allTasks
//            }
//            .store(in: &cancellables)
//
//        deleteTasks()
        
        
    }
    
    
    func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            tasks = try cdManager.context.fetch(request)
        } catch let error {
            print("Error fetching: \(error)")
        }
    }
    
    func deleteTasks() {
        tasks.forEach { t in
            cdManager.delete(object: t)
        }
    }
    
    func fetchTags() {
        let request = NSFetchRequest<TagEntity>(entityName: "TagEntity")
        
        do {
            tags = try cdManager.context.fetch(request)
//            print("Tags: \(tags)")
            tags.forEach {print("tagName: \($0.name)")}
        } catch let error {
            print("Error fetching: \(error)")
        }
    }
    
    func performAdd() {
        
        let tags = [
            Tag(name: "Work", fontColor: "FD5B71"),
            Tag(name: "Coding", fontColor: "FD5B71"),
            Tag(name: "Workout", fontColor: "FFA656"),
            Tag(name: "Reading", fontColor: "07E092"),
        ]
        
        let icons = [
            Icon(imageName: "monitor", backgroundColor: "9B51E0")

        ]
        
        let t = Task(title: "Learn IOS", date: Date(), durationSeconds: 7200, icon: icons[0], tags: [tags[0], tags[1]])
        
        addTask(task: t)
//        tags.forEach {addTag(tag: $0)}
    }
   
    func addTask(task: Task) {
        let entity = TaskEntity(context: cdManager.context)
        entity.id = task.id
        entity.title = task.title
        entity.date = task.date
        entity.durationSeconds = Int64(task.durationSeconds)
        entity.passedSeconds = Int64(task.passedSeconds)
        entity.iconName = task.icon.imageName
        entity.addToTags([tags[0], tags[1]])
        cdManager.save()
    }
    
    
    func addTag(tag: Tag) {
        let entity = TagEntity(context: cdManager.context)
        entity.id = tag.id
        entity.name = tag.name
        entity.fontColor = tag.fontColor
        cdManager.save()
    }
   
    
    func convertTagEntity(tagEntity: TagEntity) -> Tag {
        return Tag(id: tagEntity.id ?? UUID().uuidString, name: tagEntity.name ?? "", fontColor: tagEntity.fontColor ?? "")
    }
}


struct Test: View {
    @StateObject var vm = TestViewModel()
    var body: some View {
        VStack {
            ForEach(vm.tasksModels) { task in
                TaskView(task: task)
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
