//
//  ZQMainViewController.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/18.
//

import UIKit
//import Rswift

class ZQMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initChildViewController()
    }
    
    func initChildViewController() {
        setupChildViewController(controller: ZQHomeViewController(), title: "首页", norImage: R.image.btn_home_normal()!, selectedImage: R.image.btn_home_selected()!)
        setupChildViewController(controller: ZQLiveViewController(), title: "直播", norImage: R.image.btn_column_normal()!, selectedImage: R.image.btn_column_selected()!)
        setupChildViewController(controller: ZQFollowViewController(), title: "关注", norImage: R.image.btn_live_normal()!, selectedImage: R.image.btn_live_selected()!)
        setupChildViewController(controller: ZQProfileViewController(), title: "我的", norImage: R.image.btn_user_normal()!, selectedImage: R.image.btn_user_selected()!)
    }
    
    func setupChildViewController(controller: UIViewController, title: String, norImage: UIImage, selectedImage: UIImage) {
        controller.tabBarItem.title = title
        // 修改TabBar标题位置
        controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        controller.tabBarItem.image = norImage
        controller.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        // 设置 NavigationController
        let navVC = ZQNavigationController(rootViewController: controller)
//        controller.title = title
        self.addChild(navVC)
    }

}
