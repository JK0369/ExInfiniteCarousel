//
//  ViewController.swift
//  ExInfiniteCarousel
//
//  Created by 김종권 on 2022/12/01.
//

import UIKit

class ViewController: UIViewController {
  static let collectionViewHeight = 120.0
  static let width = UIScreen.main.bounds.width
  
  private let items = (1...5).map { String($0) }
  
  private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = .init(width: width, height: collectionViewHeight)
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
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: Self.collectionViewHeight)
    ])
    
    collectionView.dataSource = self
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    items.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    cell.prepare([UIColor.green, .red, .blue].randomElement(), items[indexPath.item])
    return cell
  }
}

