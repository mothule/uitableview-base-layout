//
//  CarouselTableViewCell.swift
//  TableView
//
//  Created by mothule on 2019/10/09.
//  Copyright © 2019 mothule. All rights reserved.
//

import Foundation
import UIKit

class CarouselTableViewCell: UITableViewCell, Nibable {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    private var images: [String] = []
    private var timer: Timer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        pageControl.addTarget(self, action: #selector(onTouchedPageControl(_:)), for: .valueChanged)
    
        scheduleAutoSwipe()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func setup(imageURLs: [String]) {
        pageControl.numberOfPages = imageURLs.count
        pageControl.currentPage = 0
        images = imageURLs
        setupCollectionViewLayout()
    }
    
    @objc private func onTouchedPageControl(_ sender: UIPageControl) {
        let path = IndexPath(item: sender.currentPage, section: 0)
        collectionView.scrollToItem(at: path, at: .left, animated: true)
        
        // 操作されたらタイマーリセット
        scheduleAutoSwipe()
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = layout
    }
    
    private func scheduleAutoSwipe() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.pageControl.movePage(dir: .next)
            self.onTouchedPageControl(self.pageControl)
        })
    }
}

extension CarouselTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CarouselCollectionViewCell.self, for: indexPath)
        let image = images[indexPath.item]
        cell.setup(imageURL: image)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
    }
}

class CarouselCollectionViewCell: UICollectionViewCell, Nibable {
    @IBOutlet private weak var imageView: UIImageView!
    
    func setup(imageURL: String) {
        let url = URL(string: imageURL)!
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                    self.imageView.setNeedsLayout()
                }
            }
        }.resume()
    }
}
