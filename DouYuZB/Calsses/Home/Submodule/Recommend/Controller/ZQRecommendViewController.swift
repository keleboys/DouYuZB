//
//  ZQRecommendViewController.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/18.
//

import UIKit

private let itemMargin: CGFloat = 10
private let normalItemWidth: CGFloat = (screenWidth - itemMargin*3)*0.5
private let normalItemHeight = normalItemWidth*0.75
private let prettyItemHeight = normalItemWidth*4/3

private let headerHeight: CGFloat = 50
private let COLLECTIONVIEWNORMALCELLID = "collectionViewNormalCellID"
private let COLLECTIONVIEWBEAUTIFULCELLID = "collectionViewBeautifulCellID"
private let kHeaderViewID = "kHeaderViewID"
class ZQRecommendViewController: ZQBaseViewController {
    
    var contentHeight: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func initViews() {
        
        view.addSubview(collectionView)
    }
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: screenWidth, height: headerHeight)
        layout.footerReferenceSize = CGSize.zero
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: itemMargin, right: itemMargin)

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

}

extension ZQRecommendViewController{
    
    
}

extension ZQRecommendViewController: UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ZQRecommendViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: normalItemWidth, height: prettyItemHeight)
        }
        
        return CGSize(width: normalItemWidth, height: normalItemHeight)
    }
}

extension ZQRecommendViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: ZQRecommendheaderView = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as? ZQRecommendheaderView)!
        headerView.titleLabel.text = "手机"
        headerView.iconView.image = R.image.home_header_phone()
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell: ZQBeautifulCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTIONVIEWBEAUTIFULCELLID, for: indexPath) as! ZQBeautifulCollectionCell
            cell.nameLabel.text = "来例子"
            cell.addressLabel.text = "大女解放军"
            cell.onlineLabel.text = "  9999999人在线  "
            return cell
        }else{
            let cell: ZQNormalCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTIONVIEWNORMALCELLID, for: indexPath) as! ZQNormalCollectionCell
            cell.titleLabel.text = "小李子"
            cell.onlineLabel.text = "999999999人在线"
            cell.nameLabel.text = "东方播哦哦哦哦不不不"
            return cell
        }
        
    }
}

extension ZQRecommendViewController: ZQRecommendheaderViewDelegate{
    func recommendheaderViewWithClickMoreAction(_ index: Int) {
        print(index)
    }
}
