//
//  Category.swift
//  Todoey
//
//  Created by Psirogiannis Dimitris on 12/12/2019.
//  Copyright © 2019 Psirogiannis Dimitris. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
