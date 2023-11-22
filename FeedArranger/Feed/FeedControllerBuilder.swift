//
//  FeedControllerBuilder.swift
//  FeedArranger
//
//  Created by Tolga Taş on 22.11.2023.
//

import Foundation

protocol FeedControllerBuilder {
    func buildFeed() -> FeedViewController
}

final class FeedControllerBuilderImp: FeedControllerBuilder {
    func buildFeed() -> FeedViewController {
        let vc = FeedViewController()
        let viewModel = FeedViewModelImp()
        let UIProvider = FeedUIProviderImp()
        vc.inject(vm: viewModel, provider: UIProvider)
        return vc
    }
}
