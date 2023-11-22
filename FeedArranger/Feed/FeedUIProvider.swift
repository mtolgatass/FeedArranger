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
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()
    
    private var footerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private var menuButton: UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "line.3.horizontal", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Feedler Düzenlensinnn"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
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
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = true
        return collection
    }()
    
    func addSubview(targetView: UIView) {
        targetView.addSubview(headerContainer)
        headerContainer.addSubview(headerLabel)
        headerContainer.addSubview(menuButton)
        targetView.addSubview(feedCollectionView)
        targetView.addSubview(footerContainer)
    }
    
    func addConstraints() {
        headerContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        menuButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
            make.height.width.equalTo(32)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
        
        feedCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerContainer.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.80)
        }
        
        footerContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
}

extension FeedUIProviderImp {
    enum UserActivity { }
}
