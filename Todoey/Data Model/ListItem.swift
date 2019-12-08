//
//  ListItem.swift
//  Todoey
//
//  Created by Psirogiannis Dimitris on 07/12/2019.
//  Copyright © 2019 Psirogiannis Dimitris. All rights reserved.
//

import Foundation

class ListItem : Encodable, Decodable {
    
    private var checked : Bool
    
    private var todo : String
    
    init(todo : String, checked : Bool) {
        self.todo = todo
        self.checked = checked
    }
    
    func setChecked(checked : Bool){
        
        self.checked = checked
    
    }
    
    func setTodo(todo : String){
        
        self.todo = todo

    }
    
    func getCheckedState() -> Bool {
        return self.checked
    }
    
    func getTodo() -> String {
        return self.todo
    }
    
    
    
}
