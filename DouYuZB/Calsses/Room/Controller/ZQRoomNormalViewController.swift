//
//  ZQRoomNormalViewController.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/31.
//

import UIKit

class ZQRoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    var anchorModel: AnchorModel? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = anchorModel?.nickname
        view.backgroundColor = UIColor.white
    }
}
