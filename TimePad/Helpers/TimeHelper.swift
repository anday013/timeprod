//
//  TimeHelper.swift
//  TimePad
//
//  Created by Anday on 17.07.21.
//

import Foundation


func formatTime(hours: Int, minutes: Int, seconds: Int) -> String {
    var formattedTime: String = ""
    formattedTime.append(hours < 10 ? "0\(hours)" : "\(hours)")
    formattedTime.append(":")
    formattedTime.append(minutes < 10 ? "0\(minutes)" : "\(minutes)")
    formattedTime.append(":")
    formattedTime.append(seconds < 10 ? "0\(seconds)" : "\(seconds)")
    return formattedTime
}
