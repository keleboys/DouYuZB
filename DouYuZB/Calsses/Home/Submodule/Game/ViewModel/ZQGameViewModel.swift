//
//  ZQGameViewModel.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/30.
//

import UIKit

class ZQGameViewModel {
    lazy var games : [ZQGameModel] = [ZQGameModel]()
}
//http://capi.douyucdn.cn/api/v1/getColumnDetail?&shortName=game
extension ZQGameViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            print(result)
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(ZQGameModel.deserialize(from: dict)!)
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
