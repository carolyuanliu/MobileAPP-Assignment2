//
//  XMLPlayerParser.swift
//  Juventus
//
//  Created by Yuan Liu on 08/03/2021.
//

import Foundation
class XMLTeamParser : NSObject, XMLParserDelegate{
    //name property
    var name: String
    init(name: String){self.name = name}
    
    //vars to enable parsing
    var pName, pNumber, pPosition, pNationality, pDateOfBirth, pImage, pProfile, pUrl : String!
    
    var passData    = false
    var passElement = -1
    
    // parser + model data
    var parser : XMLParser!
    var teamData = [Player]() //empty array
    
    var tags = ["name", "number", "position", "nationality", "dateOfBirth", "image", "profile", "url"]
    
    // delegate methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        // check if elementName is in tags
        if tags.contains(elementName){
            // reset the spies
            passData = true
            
            switch elementName{
                case "name"        : passElement = 0
                case "number"      : passElement = 1
                case "position"    : passElement = 2
                case "nationality" : passElement = 3
                case "dateOfBirth" : passElement = 4
                case "image"       : passElement = 5
                case "profile"     : passElement = 6
                case "url"         : passElement = 7
            default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // reset the spies
        passData    = false
        passElement = -1
        
        // what if person tag?
        if elementName == "player"{
            teamData.append(Player(name: pName, number: pNumber, position: pPosition, nationality: pNationality, dateOfBirth: pDateOfBirth, image: pImage, profile: pProfile, url: pUrl))
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // are those chars important?
        if passData{
            // store string to one of pVars
            switch passElement{
                case 0 : pName = string
                case 1 : pNumber = string
                case 2 : pPosition = string
                case 3 : pNationality = string
                case 4 : pDateOfBirth = string
                case 5 : pImage = string
                case 6 : pProfile = string
                case 7 : pUrl = string
            default: break
            }
        }
    }
    
    // parsing starts
    func parsing(){
        // locate the xml file
        let bundleURL = Bundle.main.bundleURL
        let fileURL   = URL(fileURLWithPath: self.name, relativeTo: bundleURL)
        
        // make XMLParser
        parser = XMLParser(contentsOf: fileURL)
        
        // delegate and parse
        parser.delegate = self
        parser.parse()
    }
}
