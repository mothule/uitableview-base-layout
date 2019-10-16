//
//  ApiClient.swift
//  TableView
//
//  Created by mothule on 2019/10/09.
//  Copyright © 2019 mothule. All rights reserved.
//

import Foundation

struct TopPageResponse {
    let carouselImageURLs: [String]
    let items: [Item]
    let rankingItems: [Item]
}

let fake: TopPageResponse = TopPageResponse(
    carouselImageURLs: [
        "https://blog.mothule.com/assets/images/2019-09-18-ios-swift-rxswfit-basic.png",
        "https://blog.mothule.com/assets/images/2019-09-10-necessary-continual-behavior-for-engineer.png",
        "https://blog.mothule.com/assets/images/2019-02-24-recommend-httpie.png"
    ],
    items: [
        Item(imageURL: "https://via.placeholder.com/150", name: "150", price: 1500),
        Item(imageURL: "https://via.placeholder.com/150", name: "hoge", price: 1500),
        Item(imageURL: "https://via.placeholder.com/150", name: "fuga", price: 150),
        Item(imageURL: "https://via.placeholder.com/150", name: "nuga", price: 230),
        Item(imageURL: "https://via.placeholder.com/150", name: "nuu", price: 3230),
        Item(imageURL: "https://via.placeholder.com/150", name: "130", price: 1300)
    ],
    rankingItems: [
        Item(imageURL: "https://via.placeholder.com/150", name: "150", price: 1500),
        Item(imageURL: "https://via.placeholder.com/150", name: "hoge", price: 1500),
        Item(imageURL: "https://via.placeholder.com/150", name: "fuga", price: 150)
    ]
)



class ApiClient {
    static var shared = ApiClient()
    
    func getTopPage(completion: @escaping (TopPageResponse) -> Void ) {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 0.3)
            DispatchQueue.main.async {
                completion(fake)
            }
        }
    }
}
