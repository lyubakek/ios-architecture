//
//  TVShowsDetailActionBinder.swift
//  tmdb-rx-driver
//
//  Created by Liubov Kovalchuk on 25.01.2022.
//

import Foundation

final class ShowDetailActionBinder: ViewControllerBinder {
    unowned let viewController: ShowDetailViewController
    private let driver: ShowDetailDriving
    
    init(viewController: ShowDetailViewController,
         driver: ShowDetailDriving) {
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
