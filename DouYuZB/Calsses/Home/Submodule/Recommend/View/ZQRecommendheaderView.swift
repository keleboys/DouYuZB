//
//  ZQRecommendheaderView.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/19.
//

import UIKit
import SnapKit

protocol ZQRecommendheaderViewDelegate: AnyObject {
    func recommendheaderViewWithClickMoreAction(_ index: Int)
}


class ZQRecommendheaderView: UICollectionReusableView {
    weak var delegate: ZQRecommendheaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(iconView)
        self.addSubview(arrowView)
        self.addSubview(titleLabel)
        self.addSubview(moreLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapAction(){
        self.delegate?.recommendheaderViewWithClickMoreAction(0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        arrowView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.right.equalTo(-10)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        
        moreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.right.equalTo(arrowView.snp_left).offset(-5)
            make.height.equalTo(iconView)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp_right).offset(5)
            make.right.equalTo(moreLabel.snp_left).offset(-5)
            make.height.equalTo(iconView)
        }
    }
    
    lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        return iconView
    }()
    
    private lazy var arrowView: UIImageView = {
        let arrowView = UIImageView(image: R.image.btn_more())
        return arrowView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private lazy var moreLabel: UILabel = {
        let moreLabel = UILabel()
        moreLabel.font = UIFont.systemFont(ofSize: 14)
        moreLabel.textColor = .gray
        moreLabel.textAlignment = .right
        moreLabel.text = "更多"
        return moreLabel
    }()
}
