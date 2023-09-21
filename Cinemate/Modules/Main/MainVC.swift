//
//  ViewController.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 18/09/23.
//

import UIKit
enum GeneralSection {
    case main
    case loadingIndicator
}
struct LoadingIndicatorItem: Hashable { let id = UUID() }
typealias GeneralCDataSource = UICollectionViewDiffableDataSource<GeneralSection, AnyHashable>
typealias GeneralCSnapshot = NSDiffableDataSourceSnapshot<GeneralSection, AnyHashable>

class MainVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = configureCollectionView()
    private lazy var dataSource = configureDataSource()
    private var snapshot: GeneralCSnapshot
    private var model: MainEntity = .init()
    var presenter: MainPresenterInput!

    init() {
        self.snapshot = GeneralCSnapshot()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a UIBarButtonItem with the custom view
        let barButtonItem = UIBarButtonItem(title: "All Genres", image: nil, target: self, action: #selector(genresTapped))
        barButtonItem.tintColor = .white
        self.navigationItem.leftBarButtonItem = barButtonItem
        
        view.backgroundColor = .black
        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeArea()
        collectionView.dataSource = self.dataSource
        presenter.viewDidLoad()
    }
    @objc func genresTapped() {
        presenter.didTapGenres()
    }
    func genreSelected(with item: AnyHashable) {
        
    }
    private func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(ImageCVCell.self)
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
extension MainVC: MainPresenterOutput {
    func displayMovies(_ movies: [Movie]) {
        if !snapshot.sectionIdentifiers.contains(.main) {
            snapshot.appendSections([.main])
            dataSource.apply(snapshot)
        }
        snapshot.appendItems(movies, toSection: .main)
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
                snapshot.deleteSections([.loadingIndicator])
            }
        }
        DispatchQueue.main.async {
            self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    func displayError(_ message: String) {
        
    }
    
    func displayGenreName(_ title: String) {
        self.navigationItem.leftBarButtonItem?.title = title
    }
    
    func removeExistingMovies() {
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .main))
        DispatchQueue.main.async {
            self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
}
extension MainVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.bounds.height
        
        // Define a threshold (e.g., 100 pixels from the bottom) to trigger the "load more" action
        let loadMoreThreshold: CGFloat = 20
        
        // Check if the user has scrolled close to the bottom
        if contentOffsetY + screenHeight + loadMoreThreshold >= contentHeight {
            presenter.loadMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movies = snapshot.itemIdentifiers(inSection: .main) as? [Movie] {
            self.presenter.didTapMovie(movie: movies[indexPath.row])
        }
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
