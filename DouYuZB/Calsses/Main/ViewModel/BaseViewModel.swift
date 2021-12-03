//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/20.
//

import Foundation

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}


extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            // 1.对界面进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.判断是否分组数据
            if isGroupData {
                // 2.1.遍历数组中的字典
                for dict in dataArray {
                    let group = AnchorGroup.deserialize(from: dict)
                    let room_list = dict["room_list"] as! [[String: AnyObject]]
                    var array:[AnchorModel] = []
                    for dict in room_list {
                        array.append(AnchorModel.deserialize(from: dict)!)
                    }
                    group?.anchors = array
                    self.anchorGroups.append(group!)
                }
            } else {
                // 2.1.创建组
                let group = AnchorGroup()
                
                // 2.2.遍历dataArray的所有的字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel.deserialize(from: dict)!)
                }
                
                // 2.3.将group,添加到anchorGroups
                self.anchorGroups.append(group)
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
