//
//  DetailVC.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit

typealias DetailDataSource = UICollectionViewDiffableDataSource<DetailSection, AnyHashable>
typealias DetailSnapshot = NSDiffableDataSourceSnapshot<DetailSection, AnyHashable>

class DetailVC: UIViewController {
    
    private var model: DetailEntiy
    var presenter: DetailPresenterInput!
    private lazy var collectionView: UICollectionView = configureCollectionView()
    private lazy var dataSource = configureDataSource()
    private var snapshot = DetailSnapshot()

    init(entity: DetailEntiy) {
        model = entity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = model.movie.title
        view.addSubview(collectionView)
        collectionView.fillSuperView()
        collectionView.dataSource = self.dataSource

        presenter.viewdidLoad(entity: model)
    }
    
    private func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(ImageCVCell.self)
        collectionView.register(DetailTitleCell.self)
        collectionView.register(HeaderVideoCell.self)
        collectionView.register(DetailOverviewCell.self)
        collectionView.register(DetailReviewItemCell.self)
        collectionView.register(header: DetailReviewHeaderView.self)
        collectionView.register(footer: DetailReviewFooterView.self)
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
        case .suggestion:
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
        case .backdrop:
            return defaultLayout(with: 200)
        case .title:
            return defaultLayout(with: 50)
        case .headerVideos:
            return defaultLayout(with: 44)
        case .description:
            return defaultLayout(with: 44)
        case .reviews:
            return createHorizontalScroll()        }
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
    func createHorizontalScroll() -> NSCollectionLayoutSection {
        let width = Int(screenWidth * 0.37)
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(CGFloat(width)), heightDimension: .absolute(192)))
//        item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(screenWidth), heightDimension: .absolute(192)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 8, leading: 12, bottom: 12, trailing: 12)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading),
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .topLeading)
        ]
        return section
    }
    private func configureDataSource() -> DetailDataSource {
        let _dataSource = DetailDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let section = self.snapshot.sectionIdentifiers[indexPath.section]
            switch section {
            case .backdrop:
                let cell: ImageCVCell = collectionView.dequeue(at: indexPath)
                if let path = itemIdentifier as? String {
                    cell.bind(with: path)
                }
                return cell
            case .title:
                let cell: DetailTitleCell = collectionView.dequeue(at: indexPath)
                if let model = itemIdentifier as? MovieTitles {
                    cell.bind(with: model)
                }
                return cell
            case .headerVideos:
                let cell: HeaderVideoCell = collectionView.dequeue(at: indexPath)
                if let model = itemIdentifier as? MovieVideo {
                    cell.bind(with: model)
                    cell.onTapPlay = { [weak self] in
                        if let key = model.key,
                        let ytUrl = URL(string: "https://www.youtube.com/watch?v=\(key)") {
                            UIApplication.shared.open(ytUrl)
                        }
                    }
                }
                return cell
            case .description:
                let cell: DetailOverviewCell = collectionView.dequeue(at: indexPath)
                if let model = itemIdentifier as? MovieOverview {
                    cell.bind(with: model)
                }
                return cell
            case .reviews:
                let cell: DetailReviewItemCell = collectionView.dequeue(at: indexPath)
                if let model = itemIdentifier as? MovieReview {
                    cell.bind(with: model)
                }
                return cell
            default:
                let cell: ImageCVCell = collectionView.dequeue(at: indexPath)
                if let path = itemIdentifier as? String {
                    cell.bind(with: path)
                }
                return cell
            }
            
        }
        _dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header: DetailReviewHeaderView = collectionView.dequeue(header: indexPath)
                return header
            default:
                let footer: DetailReviewFooterView = collectionView.dequeue(footer: indexPath)
                return footer
            }
        }
        snapshot.appendSections([.backdrop, .title, .headerVideos, .description, .reviews])
        snapshot.appendItems([model.movie.backdrop_path], toSection: .backdrop)
        snapshot.appendItems([model.movie.toTitle()], toSection: .title)
        snapshot.appendItems([model.movie.toOverview()], toSection: .description)
        _dataSource.apply(snapshot)
        return _dataSource
    }
}

extension DetailVC: DetailPresenterOutput {
    func displayVideos(_ videos: [MovieVideo]) {
        if let ytKey = videos.first(where: {$0.site?.lowercased() == "youtube"}) {
            snapshot.appendItems([ytKey], toSection: .headerVideos)
            self.dataSource.apply(snapshot)
        }
    }
    
    func displayReviews(_ reviews: [MovieReview]) {
        snapshot.appendItems(reviews, toSection: .reviews)
        self.dataSource.apply(snapshot)
    }
}
