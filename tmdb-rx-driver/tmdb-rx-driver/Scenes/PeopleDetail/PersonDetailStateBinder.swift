//
//  PersonDetailStateBinder.swift
//  tmdb-rx-driver
//
//  Created by Liubov Kovalchuk on 25.01.2022.
//

import Foundation
import Nuke

final class PersonDetailStateBinder: ViewControllerBinder {
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
        viewController.statusBarStyle = .lightContent
        
        viewController.bag.insert(
            viewController.rx.viewWillAppear
                .bind(onNext: unowned(self, in: PersonDetailStateBinder.viewWillAppear)),
            driver.data
                .drive(onNext: unowned(self, in: PersonDetailStateBinder.configure))
        )
    }
    
    private func configure(_ data: PersonDetailData) {
        
        viewController.nameLabel.text = data.name
        if let url = data.profileUrl {
            Nuke.loadImage(with: URL(string: url)!, into: viewController.imageView)
        }
    }
    
    private func viewWillAppear(_ animated: Bool) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
