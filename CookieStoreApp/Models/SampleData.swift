//
//  SampleData.swift
//  CookieStoreApp
//
//  Created by Kate Alyssa Joanna L. de Leon on 2/18/25.
//

import Foundation

class SampleData {
    static let shared = SampleData()

    var cookies: [Cookie] = [
        Cookie(name: "Chocolate Chip", price: 2.99, imageName: "dark_choco", type: "Dark Chocolate", inventory: 10),
        Cookie(name: "Chocolate Chip", price: 2.99, imageName: "milk_choco", type: "Milk Chocolate", inventory: 10),
        Cookie(name: "Chocolate Chip", price: 2.99, imageName: "red_cookie", type: "Red Velvet", inventory: 10),
        Cookie(name: "Crinkle", price: 5.49, imageName: "red_crinkle", type: "Red Velvet", inventory: 15),
        Cookie(name: "Crinkle", price: 5.49, imageName: "choco_crinkle", type: "Chocolate", inventory: 15),
        Cookie(name: "Crinkle", price: 5.49, imageName: "lemon_crinkle", type: "Lemon", inventory: 15),
        Cookie(name: "Crinkle", price: 5.49, imageName: "ube_crinkle", type: "Ube", inventory: 15),
        Cookie(name: "Gingerbread", price: 3.49, imageName: "gingerbread", type: nil, inventory: 5)
        
    ]

    var users: [User] = [
        User(username: "admin", password: "password"),
        User(username: "user1", password: "1234")
    ]

    var currentUser: User?

    // Function to log in a user
    func login(username: String, password: String) -> Bool {
        if let user = users.first(where: { $0.username == username && $0.password == password }) {
            currentUser = user
            return true
        }
        return false
    }

    // Function to log out the user
    func logout() {
        currentUser = nil
    }
}

