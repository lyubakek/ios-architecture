//
//  PersonDetailActionBinder.swift
//  tmdb-rx-driver
//
//  Created by Liubov Kovalchuk on 25.01.2022.
//

import Foundation

final class PersonDetailActionBinder: ViewControllerBinder {
    unowned let viewController: PersonDetailViewController
    private let driver: PersonDetailDriving
    
    init(viewController: PersonDetailViewController,
         driver: PersonDetailDriving) {
        self.viewController = viewController
        self.driver = driver
        bind()
    }
    
    func dispose() { }
    
    func bindLoaded() {
        viewController.bag.insert(
            viewController.backButton.rx.tap
                .bind(onNext: driver.close)
        )
    }
}
