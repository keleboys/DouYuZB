//
//  ZQNormalCollectionCell.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/19.
//

import UIKit

class ZQNormalCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(coverView)
        coverView.addSubview(nameLabel)
        coverView.addSubview(onlineView)
        coverView.addSubview(onlineLabel)
        self.addSubview(videoView)
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.left.equalTo(10)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.height.equalTo(videoView)
            make.left.equalTo(videoView.snp_right).offset(5)
            make.right.equalTo(-10)
        }
        
        coverView.snp.makeConstraints { (make) in
            make.top.width.left.equalToSuperview()
            make.bottom.equalTo(videoView.snp_top).offset(-10)
        }
        
        onlineLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.right.equalTo(-10)
            make.width.lessThanOrEqualTo(self.frame.width*0.30)
            make.height.equalTo(20)
        }
        
        onlineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(onlineLabel)
            make.right.equalTo(onlineLabel.snp_left).offset(-2)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.left.equalTo(10)
            make.right.equalTo(onlineView.snp_left).offset(-10)
            make.height.equalTo(20)
        }
    }
    
    lazy var coverView: UIImageView = {
        let coverView = UIImageView(image: R.image.img_default())
        coverView.layer.cornerRadius = 5
        coverView.layer.masksToBounds = true
        return coverView
    }()
    
    lazy var nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    lazy var onlineLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.textAlignment = .right
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private lazy var onlineView: UIImageView = {
        let arrowView = UIImageView(image: R.image.image_online())
        return arrowView
    }()
    
    private lazy var videoView: UIImageView = {
        let arrowView = UIImageView(image: R.image.home_live_cate_normal())
        return arrowView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let moreLabel = UILabel()
        moreLabel.font = UIFont.systemFont(ofSize: 14)
        moreLabel.textColor = .gray
        return moreLabel
    }()
}
