//
//  FeedViewController.swift
//  FeedArranger
//
//  Created by Tolga Taş on 22.11.2023.
//

import SnapKit

class FeedViewController: UIViewController {
    
    private var viewModel: FeedViewModel?
    private var UIProvider: FeedUIProvider?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        // Do any additional setup after loading the view.
        
        addSubviews()
        addConstraints()
        addListeners()
        setDelegates()
        UIProvider?.feedCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    private func addSubviews() {
        UIProvider?.addSubview(targetView: view)
    }
    
    private func addConstraints() {
        UIProvider?.addConstraints()
    }
    
    private func setDelegates() {
        UIProvider?.feedCollectionView.delegate = self
        UIProvider?.feedCollectionView.dataSource = self
        UIProvider?.feedCollectionView.dragDelegate = self
        UIProvider?.feedCollectionView.dropDelegate = self
    }
    
    private func addListeners() {
        viewModel?.stateClosure = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .action(let data):
                print(data)
            case .error(let error):
                guard let error = error else { return }
            }
        }
        
        UIProvider?.stateClosure = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .action(let data):
                print(data)
            case .error(let error):
                guard let error = error else { return }
            }
        }
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (collectionView.frame.width - 12) / 3, height: (collectionView.frame.width - 12) / 3)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.colors.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        guard let color = viewModel?.colors[indexPath.row] else { return item }
        item.backgroundColor = color
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = viewModel?.colors[indexPath.row]
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        if let item = coordinator.items.first {
            if let source = item.sourceIndexPath, let destination = coordinator.destinationIndexPath {
                collectionView.performBatchUpdates {
                    collectionView.deleteItems(at: [source])
                    collectionView.insertItems(at: [destination])
                    viewModel?.reorderItems(source: source.item, destination: destination.item)
                }
            }
        }
    }
}

extension FeedViewController {
    func inject(vm: FeedViewModel, provider: FeedUIProvider) {
        viewModel = vm
        UIProvider = provider
    }
}
