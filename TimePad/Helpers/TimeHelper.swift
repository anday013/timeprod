//
//  TimeHelper.swift
//  TimePad
//
//  Created by Anday on 17.07.21.
//

import Foundation


func formatTime(durationSeconds: Int) -> String {
    let hours: Int = Int(durationSeconds / 3600)
    let minutes: Int = Int(durationSeconds / 60) - hours * 60
    let seconds: Int = durationSeconds - hours * 3600 - minutes * 60
    var formattedTime: String = ""
    formattedTime.append(hours < 10 ? "0\(hours)" : "\(hours)")
    formattedTime.append(":")
    formattedTime.append(minutes < 10 ? "0\(minutes)" : "\(minutes)")
    formattedTime.append(":")
    formattedTime.append(seconds < 10 ? "0\(seconds)" : "\(seconds)")
    return formattedTime
}

func fetchFrozenTimer() -> Date? {
    return UserDefaults.standard.object(forKey: Constants.frozenTimer) as? Date
}

func saveFrozenTimer() {
    UserDefaults.standard.set(Date(), forKey: Constants.frozenTimer)
}

func removeFrozenTimer() {
    UserDefaults.standard.removeObject(forKey: Constants.frozenTimer)
}
