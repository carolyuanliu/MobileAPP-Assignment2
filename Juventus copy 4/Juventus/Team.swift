//
//  Team.swift
//  Juventus
//
//  Created by Yuan Liu on 08/03/2021.
//

import Foundation
class Team{
    var data : [Player]!
    
    init(fromXMLFile file :String){
        //create XMLParser instance
        let parser = XMLTeamParser(name: file)
        parser.parsing()
        
        //set the data
        self.data = parser.teamData
    }
    
    func getPlayer(index:Int)->Player{return data[index]}
    func getCount()->Int{return data.count}

}
