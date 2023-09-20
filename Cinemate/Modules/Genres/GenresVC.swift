//
//  GenresVC.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit

extension UIButton {
    convenience init(image: UIImage?) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        setImage(image, for: .normal)
    }
}
class GenresVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = configureCollectionView()
    let buttonClose = UIButton(image: .init(systemName: "xmark.circle.fill"))
    private lazy var dataSource = configureDataSource()
    private var snapshot: GeneralCSnapshot = GeneralCSnapshot()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonClose)
        buttonClose.square(edge: 69)
        buttonClose.centerXToSuperview()
        buttonClose.bottomToSuperview(space: -33)
        buttonClose.tintColor = .white
        buttonClose.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        
        view.addSubview(collectionView)
        collectionView.horizontalSuperview()
        collectionView.topToSuperview()
        collectionView.bottom(toAnchor: buttonClose.topAnchor, space: 8)
        collectionView.dataSource = self.dataSource
    }
    
    @objc func didTapClose() {
        self.dismiss(animated: true)
    }
    
    private func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(GenreCVCell.self)
        collectionView.register(LoadingCVCell.self)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .zero
        return collectionView
    }
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [unowned self] index, env in
            return self.sectionFor(index: index, environment: env)
        }
    }
    /// - Tag: ListAppearances
    func sectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = snapshot.sectionIdentifiers[index]
        switch section {
        case .main:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            
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
        case .loadingIndicator:
            // Define item size with a fixed height of 160
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            
            // Create an item with the defined size
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Define the spacing between items (horizontal)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            // Create a group with 3 items in 1 row
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Define the spacing between groups (vertical)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            
            // Define the spacing between sections (rows)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
            
            return section
        }
    }
    
    private func configureDataSource() -> GeneralCDataSource {
        let _dataSource = GeneralCDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            if self.snapshot.sectionIdentifiers[indexPath.section] == .loadingIndicator {
                let indicatorCell: LoadingCVCell = collectionView.dequeue(at: indexPath)
                indicatorCell.start()
                return indicatorCell
            }
            let cell: ImageCVCell = collectionView.dequeue(at: indexPath)
            if let movie = itemIdentifier as? Movie {
                cell.bind(with: movie)
            }
            return cell
        }
        
        snapshot.appendSections([.main])
        _dataSource.apply(snapshot)
        return _dataSource
    }
}
