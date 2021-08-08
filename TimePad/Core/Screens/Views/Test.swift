//
//  Test.swift
//  TimePad
//
//  Created by Anday on 30.07.21.
//

import SwiftUI


class TestViewModel: ObservableObject {
    let cdManager = CoreDateManager.instance
    @Published var tasks: [TaskEntity] = []
    @Published var tasksModels: [Task] = []
    
    init() {
        
//        let tags = [
//            Tag(name: "Work", fontColor: "FD5B71"),
//            Tag(name: "Coding", fontColor: "FD5B71")
//        ]
//        
//        let icons = [
//            Icon(imageName: "monitor", backgroundColor: "9B51E0")
//            
//        ]
//       
//        $tasks
//            .map { taskEntities -> [Task] in
//            var t: [Task] = []
//            for te in taskEntities {
//                t.append(Task(id: te.id ?? UUID().uuidString, title: te.title ?? "", date: te.date ?? Date(), durationSeconds: Int(te.durationSeconds), passedSeconds: Int(te.passedSeconds), icon: icons.first(where: {$0.imageName == te.iconName}) ?? icons[0], tags: []))
//            }
//            return t
//            }
//            .sink { allTasks in
//                self.tasksModels = allTasks
//            }
        
        
    }
    
    func performAdd() {
        
        let tags = [
            Tag(name: "Work", fontColor: "FD5B71"),
            Tag(name: "Coding", fontColor: "FD5B71")
        ]
        
        let icons = [
            Icon(imageName: "monitor", backgroundColor: "9B51E0")
            
        ]
        
        let t = Task(title: "Learn IOS", date: Date(), durationSeconds: 7200, icon: icons[0], tags: [tags[0], tags[1]])
        
        addTask(task: t)
    }
   
    func addTask(task: Task) {
        let entity = TaskEntity(context: cdManager.context)
        entity.id = task.id
        entity.title = task.title
        entity.date = task.date
        entity.durationSeconds = Int64(task.durationSeconds)
        entity.passedSeconds = Int64(task.passedSeconds)
        entity.iconName = task.icon.imageName
        entity.tagNames = task.tags?.map({ $0.name })
        
        cdManager.save()
    }
    
   
    
    
}


struct Test: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
