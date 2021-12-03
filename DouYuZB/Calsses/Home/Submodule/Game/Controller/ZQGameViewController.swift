//
//  ZQGameViewController.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/18.
//

import UIKit
private let itemMargin: CGFloat = 10
private let itemWidth: CGFloat = (screenWidth - itemMargin*2)/3
private let itemHeight = itemWidth*1.2
private let headerHeight: CGFloat = 50

private let kHeaderViewID = "kHeaderViewID"
private let cellID = "RecommendGamesViewCellId"

class ZQGameViewController: ZQBaseViewController {
    
    fileprivate lazy var gameVM: ZQGameViewModel = ZQGameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initViews() {
        self.view.addSubview(collectionView)
    }
    
    override func initDatas() {
        super.initDatas()
//        loadData()
    }
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: screenWidth, height: headerHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(ZQRecommendGamesCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(ZQRecommendheaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()

}

extension ZQGameViewController: UICollectionViewDelegate {
    
}

extension ZQGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count == 0 ? 10: gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ZQRecommendGamesCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ZQRecommendGamesCell
//        cell.backgroundColor = UIColor.randomColor()
        if gameVM.games.count != 0 {
            cell.model = gameVM.games[(indexPath as NSIndexPath).item]
        }
        return cell
    }
}

// MARK: - 请求数据
extension ZQGameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            // 1.展示全部游戏
            self.collectionView.reloadData()
            
            // 2.展示常用游戏
//            self.gameView.groups = Array(self.gameVM.games[0..<10])
            
            // 3.数据请求完成
//            self.loadDataFinished()
        }
    }
}
