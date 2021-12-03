//
//  ZQFunnyViewModel.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/30.
//

import UIKit

class ZQFunnyViewModel : BaseViewModel {

}
//http://capi.douyucdn.cn/api/v1/getColumnRoom/3?&limit=30&offset=0
extension ZQFunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
