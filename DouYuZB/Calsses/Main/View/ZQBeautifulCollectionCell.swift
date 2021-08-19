//
//  ZQBeautifulCollectionCell.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/19.
//

import UIKit

class ZQBeautifulCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(coverView)
        coverView.addSubview(onlineLabel)
        self.addSubview(nameLabel)
        self.addSubview(addressView)
        self.addSubview(addressLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addressView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.left.equalTo(10)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.bottom.height.equalTo(addressView)
            make.left.equalTo(addressView.snp_right).offset(5)
            make.right.equalTo(-10)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(addressView.snp_top).offset(-5)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(20)
        }
        
        coverView.snp.makeConstraints { (make) in
            make.top.width.left.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp_top).offset(-5)
        }
        
        onlineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.width.lessThanOrEqualTo(self.frame.width*0.35)
            make.height.equalTo(18)
        }
    }
    
    lazy var coverView: UIImageView = {
        let coverView = UIImageView(image: R.image.live_cell_default_phone())
        coverView.layer.cornerRadius = 5
        coverView.layer.masksToBounds = true
        return coverView
    }()
    
    lazy var onlineLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        titleLabel.textColor = .white
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.masksToBounds = true
        return titleLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private lazy var addressView: UIImageView = {
        let arrowView = UIImageView(image: R.image.ico_location())
        return arrowView
    }()
    
    lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = UIFont.systemFont(ofSize: 12)
        addressLabel.textColor = .gray
        return addressLabel
    }()
}
