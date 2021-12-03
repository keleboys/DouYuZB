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


class ZQCycleModel1: NSObject {
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
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    //防止崩溃，如果字典中某一个key没有对应的属性，则需要调用setValue forUndefinedKey方法
    override class func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}


@objc protocol TestDelegate {
    @objc optional func test()
}
