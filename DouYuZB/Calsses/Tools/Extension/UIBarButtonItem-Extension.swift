//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/18.
//

import UIKit

extension UIBarButtonItem{
    // 类方法创建UIBarButtonItem
    class func createBarButtonItem(_ norImage: UIImage, _ highlightImage: UIImage, _ size: CGSize) -> UIBarButtonItem {
        
        let btn = UIButton(type: .custom)
        btn.setImage(norImage , for: .normal)
        btn.setImage(highlightImage , for: .highlighted)
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
        return UIBarButtonItem(customView: btn)
        
    }
    
     
    // 实例方法创建,便利构造函数: 1.必须使用 convenience 2.在构造函数中必须使用一个设计的构造函数self
    convenience init(norImage: UIImage, highlightedImage: UIImage = UIImage(), size: CGSize = CGSize.zero) {
        let btn = UIButton(type: .custom)
        btn.setImage(norImage , for: .normal)
        if  highlightedImage.size != .zero {
            btn.setImage(highlightedImage , for: .highlighted)
        }
        
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
    
    convenience init(norImage: UIImage, highlightedImage: UIImage = UIImage(), target: AnyObject, sel: Selector, size: CGSize = CGSize.zero) {
        let btn = UIButton(type: .custom)
        btn.setImage(norImage , for: .normal)
        if  highlightedImage.size != .zero {
            btn.setImage(highlightedImage , for: .highlighted)
        }
        btn.addTarget(target, action: sel, for: .touchUpInside)
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
}
