//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/20.
//

import Foundation
import HandyJSON

class AnchorGroup: HandyJSON {
    // 该组中对应的房间信息
    var room_list: [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel.deserialize(from: dict)!)
            }
        }
    }
    // 组显示的图标
    var icon_name: String = "home_header_normal"
    // 定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    var tag_name : String = ""
    var icon_url : String = ""
    
    required init() {}
}
