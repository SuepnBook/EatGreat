//
//  InsertRepository.swift
//  EatGreat
//
//  Created by Book on 2022/7/15.
//

import Foundation

class InsertRepository {
    
    static let shared:InsertRepository = InsertRepository()
    
    private var insertLinks:[String:InsertDomainObject.Link] = [:]
}

//MARK: - READ
extension InsertRepository {
    func getLink(id:String) -> InsertDomainObject.Link? {
        return insertLinks[id]
    }
    
    func getLinks(ids:[String]) -> [InsertDomainObject.Link] {
        var links:[InsertDomainObject.Link] = []
        for id in ids{
            if let link = getLink(id: id) {
                links.append(link)
            }
        }
        return links
    }
}

//MARK: - UPDATE
extension InsertRepository {
    func updateInsertLinks(links:[RealTimeDatabaseDomainObject.Link]) {
        insertLinks = [:]
        for link in links {
            insertLinks[link.id] = .init(image: link.image,
                                         title: link.title)
        }
    }
}
