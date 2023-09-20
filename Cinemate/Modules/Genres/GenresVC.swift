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
    var presenter: GenresPresenterInput!

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
        presenter.viewDidload()
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
        collectionView.delegate = self
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
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
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
            let cell: GenreCVCell = collectionView.dequeue(at: indexPath)
            if let genre = itemIdentifier as? GenreInfo {
                cell.bind(with: genre)
            }
            return cell
        }
        
        snapshot.appendSections([.main, .loadingIndicator])
        _dataSource.apply(snapshot)
        return _dataSource
    }
}
extension GenresVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let genres = snapshot.itemIdentifiers(inSection: .main) as? [GenreInfo] {
            let genre = genres[indexPath.item]
            self.dataPickerDelegate?.didDataPicker(["genre": genre])
            self.dismiss(animated: true)
        }
    }
}
extension GenresVC: GenresPresenterOutput {
    
    func displayGenres(_ genres: [GenreInfo]) {
        if !snapshot.sectionIdentifiers.contains(.main) {
            snapshot.appendSections([.main])
            dataSource.apply(snapshot)
        }
        snapshot.appendItems(genres, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    func displayLoadingIndicator(_ isVisible: Bool) {
        if isVisible {
            if !snapshot.sectionIdentifiers.contains(.loadingIndicator) {
                snapshot.appendSections([.loadingIndicator])
            }
            snapshot.appendItems([LoadingIndicatorItem()])
        } else {
            if snapshot.sectionIdentifiers.contains(.loadingIndicator) {
                snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .loadingIndicator))
            }
        }
        DispatchQueue.main.async {
            self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    func displayError(_ message: String) {
        
    }
}
