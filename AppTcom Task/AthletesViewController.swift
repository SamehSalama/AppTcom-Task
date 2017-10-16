//
//  ViewController.swift
//  AppTcom Task
//
//  Created by Sameh Salama on 10/16/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

class AthletesViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var athletesTableView: UITableView!
    @IBOutlet weak var noResultsLabel: UILabel!

    //MARK: - Properties
    var athletesArray:[Athlete] = []
    let athleteDetailsSeguesIdentifier:String = "showAthleteDetailsSegue"
    var selectedAthlete:Athlete!

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Athletes"

        athletesTableView.dataSource = self
        athletesTableView.delegate = self

        self.getAthletes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let athleteDetailsVC = segue.destination as? AthleteDetailsViewController {
            athleteDetailsVC.athlete = self.selectedAthlete
        }
    }

    //MARK: - Communications
    func getAthletes() {

        SVProgressHUD.show()

        let networkManager = NetworkManager()

        networkManager.requestCompletionHandler = ({(JSON: Any?) -> Void in
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                if let responseJSON = JSON as? [String:Any], let athletes =  responseJSON["athletes"] as? [[String:Any]] {
                    self.athletesArray = Parser.parse(athletesData: athletes)
                }
                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                    let didGetResults:Bool = self.athletesArray.count > 0
                    self.noResultsLabel.isHidden = didGetResults
                    self.athletesTableView.isHidden = !didGetResults
                    self.athletesTableView.reloadData()
                })
            }
        })

        networkManager.errorHandler = ({(error: Any?, statusCode: Int) -> Void in
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                })
            }
        })

        networkManager.getAthletes()
    }


}

extension AthletesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.athletesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let athleteCell = tableView.dequeueReusableCell(withIdentifier: "AthleteTableViewCell") as! AthleteTableViewCell

        let athlete = self.athletesArray[indexPath.row]

        athleteCell.athleteNameLabel.text = athlete.name
        //athleteCell.athleteImageView.kf.setImage(with: URL(string:athlete.imageUrlString))
        if let athleteImageUrlString = athlete.imageUrlString, let athleteImageUrl = URL(string:athleteImageUrlString) {
            athleteCell.athleteImageView.kf.setImage(with: athleteImageUrl)
        }
        else {
            athleteCell.athleteImageView.image = #imageLiteral(resourceName: "placeholder")
        }

        return athleteCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAthlete = self.athletesArray[indexPath.row]
        self.performSegue(withIdentifier: self.athleteDetailsSeguesIdentifier, sender: self)
    }
}

