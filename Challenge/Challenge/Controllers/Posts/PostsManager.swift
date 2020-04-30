//
//  RepositoriesViewModel.swift
//  Challenge
//
//  Created by Pedro Albuquerque on 29/04/20.
//

import UIKit

class PostsManager {
    
    var posts = [PostModel]()
    
    func getPosts(completion: @escaping ([PostModel]) -> Void, error: @escaping (String) -> Void = { (error) in }){
        let route = RouterManager(router: PostRouter.getPosts)
        APIManager.sharedInstance.request(route: route) { (json) in
            let status = json["statusCode"].intValue
            guard status == 200, let results = json["resultValue"].array else {
                if !HelperDevice.checkConnection(), let saved = DAOManager.get(type: PostModel.self) as? [PostModel], saved.count > 0 {
                    self.posts = saved
                    completion(saved)
                }else{
                    error(json["statusMessage"].string ?? APIManager.errorStandard)
                }
                return
            }
            
            var posts = [PostModel]()
            results.forEach { result in
                if let post = PostModel.create(json: result) as? PostModel {
                    posts.append(post)
                }
            }

            DAOManager.save(type: PostModel.self, obj: self.posts)
            self.posts = posts
            completion(posts)
        }
    }
}
