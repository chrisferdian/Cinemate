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
        view.addSubview(collectionView)
        collectionView.horizontalSuperview()
        collectionView.topToSuperview(space: -(64 + UIApplication.topNotchHeight))
        collectionView.bottomToSuperview()
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
        case .suggestion:
            // Define item size with a fixed height of 160
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .absolute(160))
            
            // Create an item with the defined size
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Define the spacing between items (horizontal)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            // Create a group with 3 items in 1 row
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Define the spacing between groups (vertical)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            
            // Define the spacing between sections (rows)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading),
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .topLeading)
            ]
            return section
        case .backdrop:
            return defaultLayout(with: 350)
        case .title:
            return defaultLayout(with: 50)
        case .headerVideos:
            return defaultLayout(with: 44)
        case .description:
            return defaultLayout(with: 44)
        case .reviews:
            let width = CGFloat(screenWidth * 0.9)
            return createHorizontalScroll(with: .init(widthDimension: .absolute(width), heightDimension: .absolute(192)), enableSupplementaryItems: true)
        case .credits:
            return createHorizontalScroll(with: .init(widthDimension: .absolute(66), heightDimension: .absolute(66)), enableSupplementaryItems: true)
        }
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
    func createHorizontalScroll(with size: NSCollectionLayoutSize, enableSupplementaryItems: Bool) -> NSCollectionLayoutSection {
//        let width = Int(screenWidth * 0.9)
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(screenWidth), heightDimension: .estimated(size.heightDimension.dimension)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 8, leading: 12, bottom: 12, trailing: 12)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        if enableSupplementaryItems {
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            ]
        }
        return section
    }
    private func configureDataSource() -> DetailDataSource {
        let _dataSource = DetailDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let section = self.snapshot.sectionIdentifiers[indexPath.section]
            switch section {
            case .backdrop:
                let cell: ImageCVCell = collectionView.dequeue(at: indexPath)
                if let path = itemIdentifier as? String {
                    cell.bind(with: path, size: .w780)
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
            case .suggestion:
                let cell: ImageCVCell = collectionView.dequeue(at: indexPath)
                if let path = itemIdentifier as? Movie {
                    cell.bind(with: path)
                }
                return cell
            case .credits:
                let cell: ImageCVCell = collectionView.dequeue(at: indexPath)
                cell.setCorner(radius: 33)
                if let cast = itemIdentifier as? CastMovie,
                   let path = cast.profile_path {
                    cell.bind(with: path)
                }
                return cell
            }
            
        }
        _dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let section = self.snapshot.sectionIdentifiers[indexPath.section]
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header: DetailReviewHeaderView = collectionView.dequeue(header: indexPath)
                header.setTitle(with: section.sectionTitle)
                if section == .suggestion || section == .credits {
                    header.setSeeAllVisibility(isHidden: true)
                } else {
                    header.setSeeAllVisibility(isHidden: false)
                    header.onTappedSeeAll = { [weak self] in
                        guard let `self` = self else { return }
                        presenter.presentReviews(entity: self.model)
                    }
                }
                return header
            default:
                let footer: DetailReviewFooterView = collectionView.dequeue(footer: indexPath)
                return footer
            }
        }
        snapshot.appendSections([.backdrop, .title, .headerVideos, .description, .credits, .reviews, .suggestion])
        snapshot.appendItems([model.movie.backdrop_path], toSection: .backdrop)
        snapshot.appendItems([model.movie.toTitle()], toSection: .title)
        snapshot.appendItems([model.movie.toOverview()], toSection: .description)
        _dataSource.apply(snapshot)
        return _dataSource
    }
}
extension DetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = snapshot.sectionIdentifiers[indexPath.section]
        if section == .suggestion {
            if let movies = snapshot.itemIdentifiers(inSection: .suggestion) as? [Movie] {
                self.navigationController?.pushViewController(DetailBuilder.create(entity: movies[indexPath.row].toDetail()), animated: true)
            }
        }
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
    
    func displayNullReviews() {
        if snapshot.sectionIdentifiers.contains(.reviews) {
            snapshot.deleteSections([.reviews])
            self.dataSource.apply(snapshot)
        }
    }
    
    func displaySimilerMovies(_ list: [Movie]) {
        snapshot.appendItems(list, toSection: .suggestion)
        self.dataSource.apply(snapshot)
    }
    
    func displayCredits(cast: [CastMovie]) {
        snapshot.appendItems(cast, toSection: .credits)
        self.dataSource.apply(snapshot)
    }
}


extension UIApplication {
    var mainWindow: UIWindow? {
        if let scene = UIApplication.shared.connectedScenes.first,
            let windowScene = (scene as? UIWindowScene) {
            return windowScene.windows.first { $0.isKeyWindow }
        }
        return nil
    }
    class func topVC(_ base: UIViewController? = UIApplication.shared.mainWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topVC(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topVC(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topVC(presented)
        }
        return base
    }

    class func present(_ controller: UIViewController) {
        topVC()?.present(controller, animated: true)
    }

    class func push(_ controller: UIViewController) {
        let topController = topVC()
        topController?.navigationController?.pushViewController(controller, animated: true)
    }

    class var topNotchHeight: CGFloat {
        if let scene = UIApplication.shared.connectedScenes.first,
            let windowScene = (scene as? UIWindowScene) {
            return windowScene.windows.first?.safeAreaInsets.top ?? 0.0
        }
        return 0.0
    }
    class var bottomNotchHeight: CGFloat {
        if let scene = UIApplication.shared.connectedScenes.first,
            let windowScene = (scene as? UIWindowScene) {
            return windowScene.windows.first?.safeAreaInsets.bottom ?? 0.0
        }
        return 0.0
    }
}
