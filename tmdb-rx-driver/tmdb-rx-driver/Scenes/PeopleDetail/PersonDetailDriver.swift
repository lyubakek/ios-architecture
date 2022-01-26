//
//  PersonDetailDriver.swift
//  tmdb-rx-driver
//
//  Created by Liubov Kovalchuk on 25.01.2022.
//


import RxSwift
import RxCocoa

struct PersonDetailData {
    let id: Int
    let name: String
    let profileUrl: String?
}

extension PersonDetailData {
    init(person: PersonDetailResponse) {
        self.id = person.id
        self.name = person.name
        self.profileUrl = person.profileUrl.flatMap { "http://image.tmdb.org/t/p/w780/" + $0 }
    }
}

protocol PersonDetailDriving {
    var data: Driver<PersonDetailData> { get }
    var didClose: Driver<Void> { get }
    
    func close()
}

final class PersonDetailDriver: PersonDetailDriving {
    private let closeRelay = PublishRelay<Void>()
    
    private let id: Int
    private let api: TMDBApiProvider
    
    var data: Driver<PersonDetailData> {
        api.fetchPersonDetails(forPersonId: id)
            .unwrap()
            .compactMap(PersonDetailData.init(person: ))
            .asDriver()
    }
    
    var didClose: Driver<Void> { closeRelay.asDriver() }
    
    init(id: Int, api: TMDBApiProvider) {
        self.id = id
        self.api = api
    }
    
    func close() {
        closeRelay.accept(())
    }
}

extension PersonDetailDriver: StaticFactory {
    enum Factory {
        static func `default`(id: Int) -> PersonDetailDriving {
            PersonDetailDriver(id: id, api: TMDBApi.Factory.default)
        }
    }
}
