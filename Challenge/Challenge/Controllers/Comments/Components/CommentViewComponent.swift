//
//  PullViewComponent.swift
//  Challenge
//
//  Created by Pedro Albuquerque on 29/04/20.
//

import UIKit
import SnapKit

protocol CommentViewDelegate: class {
    func selected(comment: CommentModel)
}

class CommentViewComponent: UIView {
    
    weak var delegate: CommentViewDelegate?
    var comment: CommentModel?
    
    lazy var container: UIView = {
        let vw = UIView(frame: .zero)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .white
        vw.layer.shadowColor = UIColor.shadowColor.cgColor
        vw.layer.shadowOpacity = 1
        vw.layer.cornerRadius = 4
        vw.layer.shadowOffset = CGSize(width: 0, height: 0)
        return vw
    }()
    
    lazy var subTitle: UILabel = {
        var text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .avenirMedium(13)
        text.textAlignment = .left
        text.numberOfLines = 0
        text.textColor = .detailsColor
        return text
    }()
    
    lazy var userView: UserView = {
        var obj = UserView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    init(pictureURL: String = "", comment: CommentModel) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .clear
        
        self.loadSubViews()
        self.subTitle.text = comment.body
        self.userView.set(pictureUrl: pictureURL, name: comment.name, email: comment.email)
        
        self.comment = comment
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let comment = comment else {return}
        delegate?.selected(comment: comment)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        
        self.addSubview(container)
        container.snp.makeConstraints { (obj) in
            obj.top.equalTo(self.snp.top).offset(14)
            obj.left.equalTo(self.snp.left).offset(20)
            obj.right.equalTo(self.snp.right).offset(-20)
            obj.bottom.equalTo(self.snp.bottom).offset(-4)
        }
        
        container.addSubview(userView)
        userView.snp.makeConstraints { (obj) in
            obj.top.equalTo(container.snp.top).offset(10)
            obj.left.equalTo(container.snp.left).offset(14)
            obj.right.equalTo(container.snp.right).offset(-14)
        }
        
        container.addSubview(subTitle)
        subTitle.snp.makeConstraints { (obj) in
            obj.top.equalTo(userView.snp.bottom).offset(8)
            obj.left.equalTo(container.snp.left).offset(14)
            obj.right.equalTo(container.snp.right).offset(-14)
            obj.bottom.equalTo(container.snp.bottom).offset(-10)
        }
    }
}


