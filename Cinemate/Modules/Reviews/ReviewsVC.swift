//
//  ReviewsVC.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit

class ReviewsVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = configureCollectionView()
    private lazy var dataSource = configureDataSource()
    private var snapshot = GeneralCSnapshot()
    private var model: DetailEntiy
    var presenter: ReviewsPresenterInput!

    init(entity: DetailEntiy) {
        model = entity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reviews"
        view.backgroundColor = .black
        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeArea()
        collectionView.dataSource = self.dataSource
        presenter.viewdidLoad(entity: model)
    }
    
    private func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(DetailReviewItemCell.self)
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
        return defaultLayout(with: 100)
    }
    private func configureDataSource() -> GeneralCDataSource {
        let _dataSource = GeneralCDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            if self.snapshot.sectionIdentifiers[indexPath.section] == .loadingIndicator {
                let indicatorCell: LoadingCVCell = collectionView.dequeue(at: indexPath)
                indicatorCell.start()
                return indicatorCell
            }
            let cell: DetailReviewItemCell = collectionView.dequeue(at: indexPath)
            if let model = itemIdentifier as? MovieReview {
                cell.bind(with: model)
            }
            return cell
        }
        
        snapshot.appendSections([.main])
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
extension ReviewsVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.bounds.height
        
        // Define a threshold (e.g., 100 pixels from the bottom) to trigger the "load more" action
        let loadMoreThreshold: CGFloat = 20
        
        // Check if the user has scrolled close to the bottom
        if contentOffsetY + screenHeight + loadMoreThreshold >= contentHeight {
            presenter.loadMoreData(id: model.movie.id)
        }
    }
}
extension ReviewsVC: ReviewsPresenterOutput {
    
    func displayReviews(with list: [MovieReview]) {
        snapshot.appendItems(list, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(self.snapshot)
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
}
