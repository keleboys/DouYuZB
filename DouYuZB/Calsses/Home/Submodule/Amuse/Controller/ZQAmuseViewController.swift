//
//  ZQAmuseViewController.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/18.
//

import UIKit
private let itemMargin: CGFloat = 10
private let normalItemWidth: CGFloat = (screenWidth - itemMargin*3)*0.5
private let normalItemHeight = normalItemWidth*0.75
private let kMenuViewH : CGFloat = 200

private let headerHeight: CGFloat = 50
private let COLLECTIONVIEWNORMALCELLID = "collectionViewNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
class ZQAmuseViewController: ZQBaseViewController {

    var contentHeight: CGFloat = 0.0
    private lazy var viewModel = ZQAmuseViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initViews() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
        
        super.initViews()
    }
    
    override func initDatas() {
        super.initDatas()
        loadData()
    }

    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: screenWidth, height: headerHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(ZQNormalCollectionCell.self, forCellWithReuseIdentifier: COLLECTIONVIEWNORMALCELLID)
        collectionView.register(ZQRecommendheaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    fileprivate lazy var menuView : ZQAmuseMenuView = {
        let menuView = ZQAmuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: screenWidth, height: kMenuViewH)
        return menuView
    }()
}

extension ZQAmuseViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group: AnchorGroup = self.viewModel.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension ZQAmuseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: normalItemWidth, height: normalItemHeight)
    }
}

extension ZQAmuseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let group: AnchorGroup = self.viewModel.anchorGroups[indexPath.section]
        let headerView: ZQRecommendheaderView = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as? ZQRecommendheaderView)!
        headerView.group = group
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group: AnchorGroup = self.viewModel.anchorGroups[indexPath.section]
//        if indexPath.section == 1 {
//            let cell: ZQBeautifulCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTIONVIEWBEAUTIFULCELLID, for: indexPath) as! ZQBeautifulCollectionCell
//            cell.anchor = group.anchors[indexPath.row]
//            return cell
//        } else {
            let cell: ZQNormalCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTIONVIEWNORMALCELLID, for: indexPath) as! ZQNormalCollectionCell
            cell.anchor = group.anchors[indexPath.row]
            return cell
//        }
    }
}

extension ZQAmuseViewController: ZQRecommendheaderViewDelegate {
    func recommendheaderViewWithClickMoreAction(_ index: Int) {
        print(index)
    }
}

extension ZQAmuseViewController {
    func loadData() {
        viewModel.loadAmuseData {
            // 2.1.刷新表格
            self.collectionView.reloadData()
            
            // 2.2.调整数据
            var tempGroups = self.viewModel.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            // 3.数据请求完成
            self.loadDataFinished()
        }
    }
}
