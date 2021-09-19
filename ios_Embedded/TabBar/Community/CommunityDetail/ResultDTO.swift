//
//  ResultDTO.swift
//  ios_Embedded
//
//  Created by 허예원 on 2021/09/07.
//

import Foundation

class ResultDTO: Mappable{
    var results: [Result]?
    required convenience init?(map: Map) {
            self.init()
        }
        
        func mapping(map: Map) {
            documents <- map["title"]
            
        }
        
        class Documents: Mappable {
            var x: Any?
            var y: Any?
            required init?(map: Map) {
                
            }
            
            func mapping(map: Map) {
                x <- map["x"]
                y <- map["y"]
            }
            
            
        }
}
