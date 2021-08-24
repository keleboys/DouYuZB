//
//  ZQCycleModel.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/23.
//

import UIKit
import HandyJSON

class ZQCycleModel: HandyJSON {
    // 标题
    var title : String = ""
    // 展示的图片地址
    var pic_url : String = ""
    // 主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel.deserialize(from: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor : AnchorModel?
    
    required init() {}
}
