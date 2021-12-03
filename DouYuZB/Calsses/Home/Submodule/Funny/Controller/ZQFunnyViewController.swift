//
//  ZQFunnyViewController.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/18.
//

import UIKit
private let itemMargin: CGFloat = 10
private let normalItemWidth: CGFloat = (screenWidth - itemMargin*3)*0.5
private let normalItemHeight = normalItemWidth*0.75
private let prettyItemHeight = normalItemWidth*4/3
private let cycleViewHeight = screenWidth*3/8
private let gamesViewHeight: CGFloat = 90

private let headerHeight: CGFloat = 50
private let COLLECTIONVIEWNORMALCELLID = "collectionViewNormalCellID"
private let COLLECTIONVIEWBEAUTIFULCELLID = "collectionViewBeautifulCellID"
private let kHeaderViewID = "kHeaderViewID"
class ZQFunnyViewController: ZQBaseViewController {

    var contentHeight: CGFloat = 0.0
    private lazy var viewModel = RecommendViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initViews() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gamesView)
        
        collectionView.contentInset = UIEdgeInsets(top: cycleViewHeight+gamesViewHeight, left: 0, bottom: 0, right: 0)
        
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
        collectionView.register(ZQBeautifulCollectionCell.self, forCellWithReuseIdentifier: COLLECTIONVIEWBEAUTIFULCELLID)
        collectionView.register(ZQRecommendheaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    private lazy var cycleView: ZQRecommendCycleView = {
        let cycleView = ZQRecommendCycleView(frame: CGRect(x: 0, y: -cycleViewHeight-gamesViewHeight, width: screenWidth, height: cycleViewHeight))
        return cycleView
    }()
    
    private lazy var gamesView: ZQRecommendGamesView = {
        let gamesView = ZQRecommendGamesView(frame: CGRect(x: 0, y: -gamesViewHeight, width: screenWidth, height: gamesViewHeight))
        return gamesView
    }()
}

extension ZQFunnyViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group: AnchorGroup = self.viewModel.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ZQFunnyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: normalItemWidth, height: prettyItemHeight)
        }
        
        return CGSize(width: normalItemWidth, height: normalItemHeight)
    }
}

extension ZQFunnyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let group: AnchorGroup = self.viewModel.anchorGroups[indexPath.section]
        let headerView: ZQRecommendheaderView = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as? ZQRecommendheaderView)!
        headerView.group = group
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group: AnchorGroup = self.viewModel.anchorGroups[indexPath.section]
        if indexPath.section == 1 {
            let cell: ZQBeautifulCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTIONVIEWBEAUTIFULCELLID, for: indexPath) as! ZQBeautifulCollectionCell
            cell.anchor = group.anchors[indexPath.row]
            return cell
        } else {
            let cell: ZQNormalCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTIONVIEWNORMALCELLID, for: indexPath) as! ZQNormalCollectionCell
            cell.anchor = group.anchors[indexPath.row]
            return cell
        }
    }
}

extension ZQFunnyViewController: ZQRecommendheaderViewDelegate {
    func recommendheaderViewWithClickMoreAction(_ index: Int) {
        print(index)
    }
}

extension ZQFunnyViewController {
    func loadData() {
        viewModel.requestData {
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            var groups = self.viewModel.anchorGroups
            
            // 2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 2.2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            moreGroup.icon_name = "home_more_btn"
            groups.append(moreGroup)
            
            self.gamesView.cycleModels = groups
            
            // 3.数据请求完成
            self.loadDataFinished()
        }
        
        viewModel.requestCycleData {
            print(self.viewModel.cycleModels)
            self.cycleView.cycleModels = self.viewModel.cycleModels
        }
    }
}
