//
//  PullRequestModel.swift
//  Challenge
//
//  Created by Pedro Albuquerque on 29/04/20.
//

import Foundation
import HandyJSON
import RealmSwift

class CommentModel: Object, HandyJSON {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var postId: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var email: String?
    @objc dynamic var body: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
