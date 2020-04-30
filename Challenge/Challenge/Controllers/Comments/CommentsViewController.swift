//
//  PullsViewController.swift
//  Challenge
//
//  Created by Pedro Albuquerque on 29/04/20.
//

import UIKit

class CommentsViewController: ModuleController {
    
    let manager = CommentsManager()
    
    override func viewDidLoad() {
        self.title = manager.post?.title
        super.viewDidLoad()
        
        self.addRefresh()
        self.loadData()
    }
    
    func loadComponents(){
        
        self.view.backgroundColor = .backgroundColor
        self.addComponent(view: TitleView(title: "Comments"))
        manager.comments.forEach{
            let prComponent = CommentViewComponent(comment: $0)
            self.addComponent(view: prComponent)
            prComponent.delegate = self
        }
    }
    
    override func loadData(){
        super.loadData()
        self.showLoadingComponent()
        manager.getComments(completion: { (comments) in
            self.endLoadingComponent()
            if comments.count > 0 {
                self.loadComponents()
            }else{
                self.showEmptyComponent()
            }
        }) { (error) in
            self.endLoadingComponent()
            self.showEmptyComponent(title: "Ops, algo deu errado!", desc: error)
        }
    }
    
}

extension CommentsViewController: CommentViewDelegate {
    func selected(comment:  CommentModel) {
        //Action for touch on comment
    }
}


