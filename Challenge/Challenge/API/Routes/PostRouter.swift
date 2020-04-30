//
//  Router.swift
//  Challenge
//
//  Created by Pedro Albuquerque on 29/04/20.
//

import Foundation
import Alamofire

enum PostRouter: RouterConfig {
    
    case getPosts
    case getComments(postId: Int)
    
    var endPoint: String {
        switch self {
        case .getPosts:
            return "posts"
        case .getComments:
            return "posts"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var urlWithParams: String {
        switch self {
        case .getComments(let postId):
            return "\(postId)/comments"
        default:
            return ""
        }
    }
    
    var params: APIParams {
        return nil
    }
    
    var headers: APIHeaders {
        return [
            "Content-Type": "application/json; charset=UTF-8"
        ]
        
    }
    
}

