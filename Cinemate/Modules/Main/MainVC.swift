//
//  ViewController.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 18/09/23.
//

import UIKit
enum GeneralSection {
    case main
}
typealias GeneralCDataSource = UICollectionViewDiffableDataSource<GeneralSection, AnyHashable>
typealias GeneralCSnapshot = NSDiffableDataSourceSnapshot<GeneralSection, AnyHashable>

class MainVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = configureCollectionView()
    private lazy var dataSource = configureDataSource()
    private var snapshot: GeneralCSnapshot
    
    init() {
        self.snapshot = GeneralCSnapshot()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeArea()
        collectionView.dataSource = self.dataSource
    }
    
    private func configureCollectionView() -> UICollectionView {
        // Create a collection view layout
        let layout = UICollectionViewCompositionalLayout { (section, environment) -> NSCollectionLayoutSection? in
            
            // Define item size with a fixed height of 160
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .absolute(160))
            
            // Create an item with the defined size
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Define the spacing between items (horizontal)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            // Create a group with 3 items in 1 row
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Define the spacing between groups (vertical)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            
            // Define the spacing between sections (rows)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
            
            return section
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCVCell.self)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .zero
        return collectionView
    }
    
    private func configureDataSource() -> GeneralCDataSource {
        let _dataSource = GeneralCDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell: ImageCVCell = collectionView.dequeue(at: indexPath)
            
            return cell
        }
        
        snapshot.appendSections([.main])
        snapshot.appendItems([1,2,3,4,5,6])
        _dataSource.apply(snapshot)
        return _dataSource
    }
}



extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
