//
//  FeedViewModel.swift
//  FeedArranger
//
//  Created by Tolga Taş on 22.11.2023.
//

import Foundation
import UIKit

protocol FeedViewModel {
    var stateClosure: ((ObservationType<FeedViewModelImp.UserActivity, Error>) -> ())? { get set }
    var colors: [UIColor] { get set }
    func reorderItems(source: Int, destination: Int)
}

final class FeedViewModelImp: FeedViewModel {
    var stateClosure: ((ObservationType<UserActivity, Error>) -> ())?
    var colors: [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemGreen,
        .systemYellow,
        .systemBrown,
        .systemCyan,
        .black,
        .systemTeal,
        .systemIndigo,
        .systemOrange,
        .systemPurple,
        .systemMint,
        .systemPink,
        .systemBlue,
        .systemGreen,
        .systemYellow,
        .systemBrown,
        .systemCyan,
        .black
    ]
    
    func reorderItems(source: Int, destination: Int) {
        let item = colors.remove(at: source)
        colors.insert(item, at: destination)
    }
}

extension FeedViewModelImp {
    enum UserActivity {}
}

enum ObservationType<T, E> {
    case action(data: T? = nil), error(error: E?)
}
