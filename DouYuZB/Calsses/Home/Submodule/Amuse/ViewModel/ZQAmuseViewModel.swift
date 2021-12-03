//
//  ZQAmuseViewModel.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/30.
//

import UIKit

class ZQAmuseViewModel: BaseViewModel {

}

extension ZQAmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
