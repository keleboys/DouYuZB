//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/20.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
