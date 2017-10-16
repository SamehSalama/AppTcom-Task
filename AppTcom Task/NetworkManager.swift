//
//  NetworkManager.swift
//  AppTcom Task
//
//  Created by Sameh Salama on 10/16/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

/// NetworkManager is a class responsible for all server communications
class NetworkManager {



    // MARK: - Properties
    private let baseUrl                                     :String = "https://gist.githubusercontent.com/Bassem-Samy/f227855df4d197d3737c304e9377c4d4/raw/ece2a30b16a77ee58091886bf6d3445946e10a23/athletes.josn"

    private var afManager                                   :SessionManager!


    //MARK: - Network Handler
    var requestCompletionHandler: (_ value: Any?) -> (Void)
    var errorHandler:(_ value: Any?, _ statusCode: Int) -> Void

    init() {
        self.afManager = Alamofire.SessionManager()

        requestCompletionHandler = ({(nil) -> Void in})

        errorHandler = ({(nil) -> Void in})
    }


    //MARK: - Request Function
    func jsonRequest(_ request: DataRequest) -> Void {

        request.responseJSON { response in

            let statusCode = response.response?.statusCode
            let value = response.result.value

            print("\n*****\nrequest url: \(String(describing: response.request?.url))\n*****")
            print("\n*****request JSON response: \n\(String(describing: response.result.value))\n*****")
            if response.result.isFailure {
                self.errorHandler(["error" : "Connection to server failed."], 500)
                return
            }


            switch(statusCode!) {
            case 200:
                self.requestCompletionHandler(value)
                break
            default:
                self.errorHandler(value, statusCode!)
                break
            }
        }
    }


    // MARK: - Network API Functions
    func getAthletes() {

        let request = afManager.request(baseUrl)
            .validate(statusCode: 200..<501)
        jsonRequest(request)

    }

}

