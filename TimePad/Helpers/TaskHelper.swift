//
//  TaskHelper.swift
//  TimePad
//
//  Created by Anday on 09.08.21.
//

import Foundation



func isEqualTasks(_ task1: Task?, _ task2: Task?) -> Bool{
    return task1?.id == task2?.id
}

func isTaskCompleted(_ task: Task?) -> Bool {
    guard let task = task else { return false }
    return task.passedSeconds >= task.durationSeconds
}
