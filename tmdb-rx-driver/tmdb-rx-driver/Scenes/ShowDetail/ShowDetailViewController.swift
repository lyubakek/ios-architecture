//
//  TVShowsDetailViewController.swift
//  tmdb-rx-driver
//
//  Created by Liubov Kovalchuk on 25.01.2022.
//

import UIKit
import RxSwift

final class ShowDetailViewController: DisposeViewController {
    @IBOutlet private(set) var imageView: UIImageView!
    @IBOutlet private(set) var nameLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    
    
}

extension ShowDetailViewController: StaticFactory {
    enum Factory {
        static func`default`(id: Int) -> ShowDetailViewController {
            let vc = R.storyboard.main.showDetailViewController()!
            let driver = ShowDetailDriver.Factory.default(id: id)
            let stateBinder = ShowDetailStateBinder(viewController: vc, driver: driver)
            let actionBinder = ShowDetailActionBinder(viewController: vc, driver: driver)
            let navigationBinder = NavigationPopBinder<ShowDetailViewController>.Factory
                .pop(viewController: vc, driver: driver.didClose)
            vc.bag.insert(
                stateBinder,
                actionBinder,
                navigationBinder
            )
            return vc
        }
    }
}
