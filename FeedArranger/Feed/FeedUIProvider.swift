//
//  FeedUIProvider.swift
//  FeedArranger
//
//  Created by Tolga Taş on 22.11.2023.
//

import SnapKit

protocol FeedUIProvider {
    var stateClosure: ((ObservationType<FeedUIProviderImp.UserActivity, Error>) -> ())? { get set }
    var feedCollectionView: UICollectionView { get }
    func addSubview(targetView: UIView)
    func addConstraints()
}

final class FeedUIProviderImp: FeedUIProvider {
    var stateClosure: ((ObservationType<UserActivity, Error>) -> ())?
    
    private var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Feedler Düzenlensinnn"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dragInteractionEnabled = true
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collection.contentInset = UIEdgeInsets(top: 4, left: 2, bottom: 4, right: 2)
        return collection
    }()
    
    func addSubview(targetView: UIView) {
        targetView.addSubview(headerContainer)
        headerContainer.addSubview(headerLabel)
        targetView.addSubview(feedCollectionView)
    }
    
    func addConstraints() {
        headerContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        feedCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(headerContainer.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.80)
        }
    }
}

extension FeedUIProviderImp {
    enum UserActivity { }
}
