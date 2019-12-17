//
//  Item.swift
//  Todoey
//
//  Created by Psirogiannis Dimitris on 12/12/2019.
//  Copyright © 2019 Psirogiannis Dimitris. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {

    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var created_at : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")

}
