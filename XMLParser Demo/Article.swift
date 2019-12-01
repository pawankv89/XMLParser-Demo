//
//  Article.swift
//  XMLParser Demo
//
//  Created by Pawan kumar on 05/06/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation

class Article: NSObject {
    
    var title: String = ""
    var link: String = ""
    var desc: String = ""
    var pubDate: String = ""
    var titleAttrbutes: Title!
}

class Title: NSObject {
    
    var id: String = ""
    var name: String = ""
    var location: String = ""
}
