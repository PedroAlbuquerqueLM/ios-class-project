//
//  RepositoryModel.swift
//  Challenge
//
//  Created by Pedro Albuquerque on 29/04/20.
//

import Foundation
import HandyJSON
import RealmSwift

class PostModel: Object, HandyJSON {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var body: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
