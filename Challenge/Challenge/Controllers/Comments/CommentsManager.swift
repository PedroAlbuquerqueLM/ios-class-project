//
//  PullsViewModel.swift
//  Challenge
//
//  Created by Pedro Albuquerque on 29/04/20.
//

import UIKit

class CommentsManager {
    
    var post: PostModel?
    var comments = [CommentModel]()
    
    func set(post: PostModel){
        self.post = post
    }
    
    func getComments(completion: @escaping ([CommentModel]) -> Void, error: @escaping (String) -> Void = { (error) in }){
        guard let postId = post?.id else {return}
        let route = RouterManager(router: PostRouter.getComments(postId: postId))
        APIManager.sharedInstance.request(route: route) { (json) in
            let status = json["statusCode"].intValue
            guard status == 200, let results = json["resultValue"].array else {
                if !HelperDevice.checkConnection(), let saved = (DAOManager.get(type: CommentModel.self) as? [CommentModel]), saved.count > 0 {
                    self.comments = saved
                    completion(saved)
                }else{
                    error(json["statusMessage"].string ?? APIManager.errorStandard)
                }
                return
            }
            
            results.forEach { result in
                if let comment = CommentModel.create(json: result) as? CommentModel {
                    if !(self.comments.filter{$0.id == comment.id}.count > 0) {
                        self.comments.append(comment)
                    }
                }
            }
            
            DAOManager.save(type: CommentModel.self, obj: self.comments)
            completion(self.comments)
        }
    }
}

