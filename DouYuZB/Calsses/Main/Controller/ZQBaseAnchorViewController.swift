//
//  ZQBaseAnchorViewController.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/30.
//

import UIKit
private let headerHeight: CGFloat = 50
private let itemMargin: CGFloat = 10
private let normalItemWidth: CGFloat = (screenWidth - itemMargin*3)*0.5
private let normalItemHeight = normalItemWidth*0.75
private let prettyItemHeight = normalItemWidth*4/3

private let COLLECTIONVIEWNORMALCELLID = "collectionViewNormalCellID"

private let kHeaderViewID = "kHeaderViewID"

class ZQBaseAnchorViewController: ZQBaseViewController {
    private lazy var viewModel = RecommendViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initViews() {
        super.initViews()
        
        view.addSubview(collectionView)
    }
    
    
    lazy var collectionView: UICollectionView = { [unowned self] in
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

}

extension ZQBaseAnchorViewController: UICollectionViewDelegate {
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

extension ZQBaseAnchorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: normalItemWidth, height: normalItemHeight)
    }
}

extension ZQBaseAnchorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let group: AnchorGroup = self.viewModel.anchorGroups[indexPath.section]
        let headerView: ZQRecommendheaderView = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as? ZQRecommendheaderView)!
        headerView.group = group
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group: AnchorGroup = self.viewModel.anchorGroups[indexPath.section]
            let cell: ZQNormalCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTIONVIEWNORMALCELLID, for: indexPath) as! ZQNormalCollectionCell
            cell.anchor = group.anchors[indexPath.row]
            return cell
    }
}

extension ZQBaseAnchorViewController: ZQRecommendheaderViewDelegate {
    func recommendheaderViewWithClickMoreAction(_ index: Int) {
        print(index)
    }
}
