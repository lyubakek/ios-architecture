//
//  TVShowsDetailStateBinder.swift
//  tmdb-rx-driver
//
//  Created by Liubov Kovalchuk on 25.01.2022.
//

import Foundation
import Nuke

final class ShowDetailStateBinder: ViewControllerBinder {
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
        viewController.statusBarStyle = .lightContent
        
        viewController.bag.insert(
            viewController.rx.viewWillAppear
                .bind(onNext: unowned(self, in: ShowDetailStateBinder.viewWillAppear)),
            driver.data
                .drive(onNext: unowned(self, in: ShowDetailStateBinder.configure))
        )
    }
    
    private func configure(_ data: ShowDetailData) {
        viewController.nameLabel.text = data.name
        if let url = data.posterUrl {
            Nuke.loadImage(with: URL(string: url)!, into: viewController.imageView)
        }
    }
    
    private func viewWillAppear(_ animated: Bool) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
