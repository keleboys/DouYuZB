//
//  ZQBaseGameModel.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/30.
//

import HandyJSON

class ZQBaseGameModel: HandyJSON {
    
    // MARK: - 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    // 组显示的图标
    var icon_name: String = "home_header_normal"
    
    required init() {}

}
