//
//  Parser.swift
//  AppTcom Task
//
//  Created by Sameh Salama on 10/16/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import Foundation

class Parser {

    class func parse(athleteData:[String:Any]) -> Athlete {

        let athlete = Athlete()
        if let name = athleteData["name"] as? String {
            athlete.name = name
        }
        if let image = athleteData["image"] as? String {
            athlete.imageUrlString = image
        }
        if let brief = athleteData["brief"] as? String {
            athlete.brief = brief
        }
        return athlete
    }

    class func parse(athletesData:[[String:Any]]) -> [Athlete] {

        var athletesArray:[Athlete] = []

        for anAthlete in athletesData {
            let athlete = self.parse(athleteData: anAthlete)
            athletesArray.append(athlete)
        }
        return athletesArray
    }
}
