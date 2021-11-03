//
//  Player.swift
//  Juventus
//
//  Created by Yuan Liu on 08/03/2021.
//

import Foundation
class Player{
    var name: String
    var number: String
    var position: String
    var nationality: String
    var dateOfBirth: String
    var image: String
    var profile:String
    var url: String
    
    init(){
        self.name = "John Doe"
        self.number = "none"
        self.position = "none"
        self.nationality = "none"
        self.dateOfBirth = "none"
        self.image = "none"
        self.profile = "none"
        self.url = "none"
    }
    init(name: String, number: String, position: String, nationality: String, dateOfBirth: String, image: String, profile:String, url:String){
        self.name = name
        self.number = number
        self.position = position
        self.nationality = nationality
        self.dateOfBirth = dateOfBirth
        self.image = image
        self.profile = profile
        self.url = url
    }
}
