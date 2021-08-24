//
//  ZQRecommendCycleView.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/23.
//

import UIKit

private let cellID = "ecommendCycleCellId"
private let maxPage = 1000
class ZQRecommendCycleView: UIView {
    var cycleTimer : Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView )
        self.addSubview(pageControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    var cycleModels: [ZQCycleModel]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
            
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            self.collectionView.reloadData()
            
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenWidth, height: self.bounds.height)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ZQRecommendCycleCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.pageIndicatorTintColor = .gray
        return pageControl
    }()
}

extension ZQRecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

extension ZQRecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ZQRecommendCycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ZQRecommendCycleCell
        cell.model = cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]
        return cell
    }
}

// MARK: - 对定时器的操作方法
extension ZQRecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate() // 从运行循环中移除
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}


class ZQRecommendCycleCell: UICollectionViewCell {
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
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(50)
        }
    }
    
    var model: ZQCycleModel? {
        didSet {
            nameLabel.text = "    \(model?.title ?? "")"
            
            guard let iconURL = URL(string: model!.pic_url) else { return }
            coverView.kf.setImage(with: iconURL, placeholder: R.image.img_default())
        }
    }
    
    lazy var coverView: UIImageView = {
        let coverView = UIImageView(image: R.image.live_cell_default_phone())
        coverView.layer.cornerRadius = 5
        coverView.layer.masksToBounds = true
        return coverView
    }()
    
    lazy var nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return titleLabel
    }()
    
}

