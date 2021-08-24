//
//  ZQHomeViewController.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/18.
//

import UIKit


class ZQHomeViewController: ZQBaseViewController, PageTitleViewDelegate, PageContentViewDelegate {
   
    // MARK: - life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController!.navigationBar.clipsToBounds = true;
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        let num = 4.15
        let num2 = 4.85
        
        print("floor:\(floor(num+0.5))") // 向下取整 4.0
        print("floor:\(floor(num2))") // 向下取整 4.0
        
        print("ceil:\(ceil(num))") // 向上取整5.0
        print("ceil:\(ceil(num2))") // 向上取整5.0
        
        print("rounded:\(num.rounded())") // 四舍五入4.0
        print("rounded:\(num2.rounded())") // 四舍五入5.0
        
        print("pow:\(pow(10, 2))") // 幂运算 100
        
    }
    
    
    
    override func initViews() {
        setupNavigationBar()
        
        pageTitleView.delegate = self
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
    }
    
    // MARK: - PageTitleViewDelegate
    func pageTitleView(_ titleView: ZQPageTitleView, selectedIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(index)
    }
    // MARK: - PageContentViewDelegate
    func pageContentView(_ contentView: ZQPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    // MARK: - event response
    @objc func leftNavigationBarClickAction() {
        print("leftNavigationBarClickAction")
    }
    
    @objc func historyBarButtonItemClickAction() {
        print("historyBarButtonItemClickAction")
    }
    
    @objc func qrCodeBarButtonItemClickAction() {
        print("qrCodeBarButtonItemClickAction")
    }
    
    @objc func searchBarButtonItemClickAction() {
        print("searchBarButtonItemClickAction")
    }
    
    // MARK: - lazy
    private lazy var pageTitleView: ZQPageTitleView = {
        let rect =  CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        let view = ZQPageTitleView(frame: rect, titles: ["推荐", "游戏", "娱乐", "趣玩"])
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var pageContentView: ZQPageContentView = { [weak self] in
        let top = (navigationController?.navigationBar.frame.height)!+UIApplication.shared.statusBarFrame.height
        let bottom = tabBarController?.tabBar.frame.height
        print(("top\(top )"))
        print(("bottom\(bottom ?? 0)"))
        let height = screenHeight-top-bottom!-pageTitleView.frame.height
        print(("screenHeight\(screenHeight )"))
        print(("height\(height )"))
        let rect =  CGRect(x: 0, y: pageTitleView.frame.height, width: screenWidth, height: height)
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        let recommendVC = ZQRecommendViewController()
        recommendVC.contentHeight = height
        childVcs.append(recommendVC)
        childVcs.append(ZQGameViewController())
        childVcs.append(ZQAmuseViewController())
        childVcs.append(ZQFunnyViewController())
        let view = ZQPageContentView(frame: rect, childVcs: childVcs, parentViewController: self)
        view.delegate = self
        return view
    }()
}

extension ZQHomeViewController {
    func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(norImage: R.image.logo()!, target: self, sel: #selector(leftNavigationBarClickAction))
        
        let historyItem = UIBarButtonItem(norImage: R.image.image_my_history()!, highlightedImage: R.image.image_my_history_click()!, target: self, sel: #selector(historyBarButtonItemClickAction))

        let qrCodeItem = UIBarButtonItem(norImage: R.image.image_scan()!, highlightedImage: R.image.image_scan_click()!, target: self, sel: #selector(qrCodeBarButtonItemClickAction))
        
        let searchItem = UIBarButtonItem(norImage: R.image.btn_search()!, highlightedImage: R.image.btn_search_clicked()!, target: self, sel: #selector(searchBarButtonItemClickAction))
        
        navigationItem.rightBarButtonItems = [historyItem, qrCodeItem, searchItem]
    }
}
