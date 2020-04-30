//
//  ViewController.swift
//  Challenge
//
//  Created by Pedro Albuquerque on 29/04/20.
//

import UIKit

class PostsViewController: ModuleController {

    let manager = PostsManager()
    
    override func viewDidLoad() {
        self.title = "Posts"
        super.viewDidLoad()
        
        self.addRefresh()
        self.loadData()
    }
    
    override func loadMore() {
        if HelperDevice.checkConnection(){
            manager.getPosts(completion: { (posts) in
                self.loadComponents(posts: posts)
            })
        }
    }

    func loadComponents(posts: [PostModel]){
        
        self.view.backgroundColor = .backgroundColor
        
        posts.forEach{
            let repoComponent = PostViewComponent(post: $0)
            self.addComponent(view: repoComponent)
            repoComponent.delegate = self
        }
    }
    
    override func loadData(){
        super.loadData()
        self.showLoadingComponent()
        manager.getPosts(completion: { (posts) in
            self.endLoadingComponent()
            if self.manager.posts.count > 0 {
                self.loadComponents(posts: self.manager.posts)
            }else{
                self.showEmptyComponent()
            }
        }) { (error) in
            self.endLoadingComponent()
            self.showEmptyComponent(title: "Ops, algo deu errado!", desc: error)
        }
    }
}

extension PostsViewController: PostViewDelegate {
    func selected(post: PostModel) {
        let vc = CommentsViewController()
        vc.manager.set(post: post)
        self.navigationController?.show(vc, sender: nil)
    }
}

