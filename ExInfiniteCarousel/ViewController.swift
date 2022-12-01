//
//  ViewController.swift
//  ExInfiniteCarousel
//
//  Created by 김종권 on 2022/12/01.
//

import UIKit

class ViewController: UIViewController {
  enum Metric {
    static let collectionViewHeight = 120.0
    static let cellWidth = UIScreen.main.bounds.width
  }
  
  private var items = (1...3)
    .map { (String($0), [UIColor.gray, .red, .blue, .orange, .black].randomElement()) }
  
  private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = .init(width: Metric.cellWidth, height: Metric.collectionViewHeight)
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
    view.isScrollEnabled = true
    view.showsHorizontalScrollIndicator = false
    view.showsVerticalScrollIndicator = true
    view.contentInset = .zero
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isPagingEnabled = true
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // as -is: 1 2 3
    // to -be: 3 1 2 3 1
    items.insert(items[items.count-1], at: 0)
    items.append(items[1])
    
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: Metric.collectionViewHeight)
    ])
    
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.setContentOffset(.init(x: Metric.cellWidth, y: collectionView.contentOffset.y), animated: false)
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    items.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    cell.prepare(items[indexPath.item].1, items[indexPath.item].0)
    return cell
  }
}

extension ViewController: UICollectionViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let count = items.count
    
    if scrollView.contentOffset.x == 0 {
      scrollView.setContentOffset(.init(x: Metric.cellWidth * Double(count-2), y: scrollView.contentOffset.y), animated: false)
    }
    if scrollView.contentOffset.x == Double(count-1) * Metric.cellWidth {
      scrollView.setContentOffset(.init(x: Metric.cellWidth, y: scrollView.contentOffset.y), animated: false)
    }
  }
}
