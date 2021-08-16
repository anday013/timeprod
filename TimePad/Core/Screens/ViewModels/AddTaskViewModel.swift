//
//  AddTaskViewModel.swift
//  TimePad
//
//  Created by Anday on 22.07.21.
//

import Foundation
import Combine

class AddTaskViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var date: Date = Date()
    @Published var durationHours: Int = 0
    @Published var durationMinutes: Int = 0
    @Published var selectedTags: [Tag] = []
    @Published var selectedIcon: Icon = Icon(imageName: "monitor", backgroundColor: "9B51E0")
    @Published var showIconPicker: Bool = false
    @Published var showMinutePicker: Bool = false
    // Validators
    @Published var isTitleValid: Bool = true
    @Published var isDurationValid: Bool = true
    
//    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
//    func validator() {
//        $durationMinutes
//            .combineLatest($durationHours)
//            .map { (minutesVal, hoursVal) -> Bool in
//                if self.isSubmited == false {
//                    return true
//                }
//                return minutesVal != 0 || hoursVal != 0
//            }
//            .sink { [weak self] res in
//                self?.isDurationValid = res
//            }
//            .store(in: &cancellables)
//
//        $title
//            .map { titleVal -> Bool in
//                if self.isSubmited == false {
//                    return true
//                }
//                return titleVal != ""
//            }
//            .sink { [weak self] res in
//                self?.isTitleValid = res
//            }
//            .store(in: &cancellables)
//    }
    
    func submitForm(tasksVM: TasksEnvironmentViewModel) {
        print("Duration Hours: \(self.durationHours)")
        print("Duration Minutes: \(self.durationMinutes)")
        if self.durationHours != 0 || self.durationMinutes != 0 {
            isDurationValid = true
        }
        else {
            isDurationValid = false
        }
        
        if self.title == "" {
            isTitleValid = false
        }
        else {
            isTitleValid = true
        }
        
        if self.isDurationValid && self.isTitleValid {
            tasksVM.addTask(generateTaks())
        }
    }
    
    private func generateTaks() -> Task {
       return Task(title: title, date: date, durationSeconds: durationHours * Constants.secondsInHour + durationMinutes * Constants.secondsInMinutes, icon: selectedIcon, tags: selectedTags)
    }

}
