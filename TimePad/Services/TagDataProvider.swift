//
//  TagDataProvider.swift
//  TimePad
//
//  Created by Anday on 17.08.21.
//

import Foundation
import Combine
import CoreData

class TagDataProvider {
    static let instance = TagDataProvider()
    @Published var allTags: [Tag] = []
    @Published private var tagEntities: [TagEntity] = []
    var cancellables = Set<AnyCancellable>()
    let cdManager = CoreDataManager.instance

    private init() {
        entityToModelListener()
        fetchTags()
    }
    
    // PRIVATE FUNCTIONS
    private func entityToModelListener() {
        $tagEntities
            .map { entities -> [Tag] in
                return entities.compactMap({CoreDataHelper.convertToTagModel(tagEntity: $0)})
            }
            .sink(receiveValue: { [weak self] tags in
                self?.allTags = tags
            })
            .store(in: &cancellables)
    }
    
    // PUBLIC FUNCTIONS
    func fetchTags() {
        let request = NSFetchRequest<TagEntity>(entityName: "TagEntity")
        
        do {
            tagEntities = try cdManager.context.fetch(request)
        } catch let error {
            print("Error fetching: \(error)")
        }
    }
    
    func getAllTagEntities() -> [TagEntity] {
        fetchTags()
        return tagEntities
    }
    
    func deleteTag(tag: Tag) -> Bool {
        guard let target = tagEntities.first(where: {tag.id == $0.id}) else {
            print("Unable to find tag with id: \(tag.id)")
            return false
        }
        let result = cdManager.delete(object: target)
        fetchTags()
        return result
    }
    
    func addTag(tag: Tag) -> Bool {
        let _ = CoreDataHelper.convertToTagEntity(tag: tag)
        let result = cdManager.save()
        // fetchTags()
        return result
    }

}
