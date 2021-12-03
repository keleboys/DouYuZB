//
//  ZQRecommendGamesView.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/23.
//

import UIKit
private let cellID = "RecommendGamesViewCellId"
private let itemWidth: CGFloat = 80
private let itemMargin: CGFloat = 10
class ZQRecommendGamesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    var cycleModels: [AnchorGroup]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: self.bounds.height)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        collectionView.register(ZQRecommendGamesCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
}

extension ZQRecommendGamesView: UICollectionViewDelegate {

}

extension ZQRecommendGamesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ZQRecommendGamesCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ZQRecommendGamesCell
        cell.model = cycleModels![(indexPath as NSIndexPath).item]
        return cell
    }
}

class ZQRecommendGamesCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(coverView)
        self.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coverView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(self)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(coverView.snp_bottom).offset(8)
            make.height.equalTo(20)
        }
    }
    
    var model: ZQBaseGameModel? {
        didSet {
            nameLabel.text = model?.tag_name
            
            guard let iconURL = URL(string: model!.icon_url) else {
                coverView.image = UIImage(named: model!.icon_name)
                return
            }
            coverView.kf.setImage(with: iconURL, placeholder: R.image.img_default())
        }
    }
    
    lazy var coverView: UIImageView = {
        let coverView = UIImageView(image: R.image.live_cell_default_phone())
        coverView.layer.cornerRadius = 25
        coverView.layer.masksToBounds = true
        return coverView
    }()
    
    lazy var nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = "完犊子啦"
        return titleLabel
    }()
    
}

