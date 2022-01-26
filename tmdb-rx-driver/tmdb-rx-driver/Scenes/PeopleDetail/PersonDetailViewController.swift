//
//  PersonDetailViewController.swift
//  tmdb-rx-driver
//
//  Created by Liubov Kovalchuk on 25.01.2022.
//

import UIKit
import RxSwift

final class PersonDetailViewController: DisposeViewController {
    @IBOutlet private(set) var imageView: UIImageView!
    @IBOutlet private(set) var nameLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    
    

}


extension PersonDetailViewController: StaticFactory {
    enum Factory {
        static func`default`(id: Int) -> PersonDetailViewController {
            let vc = R.storyboard.main.personDetailViewController()!
            let driver = PersonDetailDriver.Factory.default(id: id)
            let stateBinder = PersonDetailStateBinder(viewController: vc, driver: driver)
            let actionBinder = PersonDetailActionBinder(viewController: vc, driver: driver)
            let navigationBinder = NavigationPopBinder<PersonDetailViewController>.Factory
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
