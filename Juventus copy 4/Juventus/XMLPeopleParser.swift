//
//  XMLPeopleParser.swift
//  Table Testing
//
//  Created by Yuan Liu on 02/03/2021.
//

import Foundation

class XMLPeopleParser : NSObject, XMLParserDelegate{
    //name property
    var name : String
    init(name:String){self.name = name}
    
    //vars to enable parsing
    var pName, pAddress, pPhone, pEmail, pImage : String!
    
    var passData    = false
    var passElement = -1
    
    // parser + model data
    var parser : XMLParser!
    var peopleData = [Person]() //empty array
    
    var tags = ["name", "address", "phone", "email", "image"]
    
    // delegate methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        // check if elementName is in tags
        if tags.contains(elementName){
            // reset the spies
            passData = true
            
            switch elementName{
                case "name"    : passElement = 0
                case "address" : passElement = 1
                case "phone"   : passElement = 2
                case "email"   : passElement = 3
                case "image"   : passElement = 4
            
                default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // reset the spies
        passData    = false
        passElement = -1
        
        // what if person tag?
        if elementName == "person"{
            peopleData.append(Person(name: pName, phone: pPhone, email: pEmail, address: pAddress, image: pImage))
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // are those chars important?
        if passData{
            // store string to one of pVars
            switch passElement{
                case 0 : pName = string
                case 1 : pAddress = string
                case 2 : pPhone = string
                case 3 : pEmail = string
                case 4 : pImage = string
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
