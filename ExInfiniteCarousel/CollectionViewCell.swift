//
//  CollectionViewCell.swift
//  ExInfiniteCarousel
//
//  Created by 김종권 on 2022/12/01.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
  // MARK: UI
  private let someView: UIView = {
    let view = UIView()
    view.backgroundColor = [UIColor.green, .red, .blue].randomElement()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let label: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .systemFont(ofSize: 32)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: Initializer
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(someView)
    contentView.addSubview(label)
    
    NSLayoutConstraint.activate([
      someView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      someView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      someView.topAnchor.constraint(equalTo: contentView.topAnchor),
      someView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: someView.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: someView.trailingAnchor),
      label.topAnchor.constraint(equalTo: someView.topAnchor),
      label.bottomAnchor.constraint(equalTo: someView.bottomAnchor)
    ])
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    prepare(nil, nil)
  }
  
  func prepare(_ color: UIColor?, _ text: String?) {
    someView.backgroundColor = color
    label.text = text
  }
}
