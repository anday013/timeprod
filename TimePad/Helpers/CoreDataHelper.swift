//
//  CoreDataHelper.swift
//  TimePad
//
//  Created by Anday on 17.08.21.
//

import Foundation


class CoreDataHelper {

    
    static func convertToTaskEntity(task: Task?, allTagEntities: [TagEntity]) -> TaskEntity? {
        let entity = TaskEntity(context: CoreDataManager.instance.context)
        guard let task = task else {return nil}
        entity.id = task.id
        entity.title = task.title
        entity.date = task.date
        entity.durationSeconds = Int64(task.durationSeconds)
        entity.passedSeconds = Int64(task.passedSeconds)
        entity.iconName = task.icon.imageName
        let convertedTags: [TagEntity] = task.tags?.compactMap({ tag -> TagEntity? in
            return allTagEntities.first(where: {tag.id == $0.id})
        }) ?? []
        entity.tags = NSSet(array: convertedTags)
        return entity
    }
    
    static func convertToTaskModel(taskEntity: TaskEntity?) -> Task? {
        guard
            let taskEntity = taskEntity,
            let id = taskEntity.id,
            let title = taskEntity.title,
            let date = taskEntity.date,
            let durationSeconds = Optional(taskEntity.durationSeconds),
            let passedSeconds = Optional(taskEntity.passedSeconds),
            let icon = Constants.icons.first(where: {$0.imageName == taskEntity.iconName}),
            let tags = taskEntity.tags?.compactMap({convertToTagModel(tagEntity: $0 as? TagEntity)})
        else {
            return nil
        }
        
        return Task(
            id: id,
            title: title,
            date: date,
            durationSeconds: Int(durationSeconds),
            passedSeconds: Int(passedSeconds),
            icon: icon,
            tags: tags
        )
    }
    
    static func convertToTagModel(tagEntity: TagEntity?) -> Tag? {
        guard
            let tagEntity = tagEntity,
            let id = tagEntity.id,
            let name = tagEntity.name,
            let fontColor = tagEntity.fontColor
        else {
            return nil
        }
        return Tag(id: id, name: name, fontColor: fontColor)
    }
    
    static func convertToTagEntity(tag: Tag?) -> TagEntity? {
        let entity = TagEntity(context: CoreDataManager.instance.context)
        guard
            let tag = tag
        else {
            return nil
        }
        entity.id = tag.id
        entity.name = tag.name
        entity.fontColor = tag.fontColor
        
        return entity
    }
    
}
