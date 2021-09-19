//
//  UserModel.swift
//  ios_Embedded
//
//  Created by 허예원 on 2021/08/05.
//

import Foundation

final class UserModel {
    struct User {
        var email: String
        var password: String
        var name: String?
        var carName: String?
        var carRealName: String?
        var carNumber: String?
        var carImage: String?
    }
    
    var users: [User] = [
        User(email: "minjun@naver.com", password: "1234", name: "최민준", carName: "붕붕쓰", carRealName: "맥라렌", carNumber: "40가1234", carImage: "mclarenImage" ),
        User(email: "yewon@naver.com", password: "1234", name: "허예원", carName: "구름이", carRealName: "Avante", carNumber: "가1234", carImage: "avanteImage")
    ]
    
    // 아이디 형식 검사
    func isValidEmail(id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    
    // 비밀번호 형식 검사
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[0-9]{4,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
} // end of UserModel
