//
//  Sets.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/01.
//

import UIKit

protocol Sets {}
extension Sets {
    @discardableResult func `do` (closure: (inout Self)-> Void) ->
    Self {
    var value = self
    closure(&value)
    return value
    }
    
}

extension NSObject: Sets {}
extension CGFloat: Sets {}
extension CGRect: Sets {}
extension CGPoint: Sets {}
extension Double: Sets {}
extension Float: Sets {}
extension Int: Sets {}
