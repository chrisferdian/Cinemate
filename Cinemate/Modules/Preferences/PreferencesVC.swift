//
//  PreferencesVC.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 23/09/23.
//

import UIKit

typealias PreferencesDataSource = UICollectionViewDiffableDataSource<GeneralSection, UserPreferenceSettings>
typealias PreferencesSnapshot = NSDiffableDataSourceSnapshot<GeneralSection, UserPreferenceSettings>

class PreferencesVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = configureCollectionView()
    private lazy var dataSource = configureDataSource()
    private var snapshot = PreferencesSnapshot()
    private var model: PreferencesEntity?
    var presenter: ReviewsPresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preferences"
        view.backgroundColor = .black
        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeArea()
        collectionView.dataSource = self.dataSource
//        presenter.viewdidLoad(entity: model)
    }
    
    private func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(PreferencesAdultCell.self)
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
        return defaultLayout(with: 100)
    }
    private func configureDataSource() -> PreferencesDataSource {
        let _dataSource = PreferencesDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .isAdultContent:
                let cell: PreferencesAdultCell = collectionView.dequeue(at: indexPath)
                if let isOn = itemIdentifier.value as? Bool {
                    cell.setValue(with: isOn)
                }
                return cell
            }
        }
        
        snapshot.appendSections([.main])
        snapshot.appendItems(UserPreferenceSettings.allCases, toSection: .main)
        _dataSource.apply(snapshot)
        return _dataSource
    }
    
    private func defaultLayout(with height: CGFloat) -> NSCollectionLayoutSection {
        // Define item size with a fixed height of 160
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(height))
        
        // Create an item with the defined size
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Define the spacing between items (horizontal)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // Create a group with 3 items in 1 row
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Define the spacing between groups (vertical)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        // Define the spacing between sections (rows)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}
