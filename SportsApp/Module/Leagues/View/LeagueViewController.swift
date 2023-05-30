//
//  LeagueViewController.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import UIKit
import Kingfisher
import Reachability

class LeagueViewController: UIViewController , UITableViewDelegate  , UITableViewDataSource{

    @IBOutlet weak var table: UITableView!
    
    var sportName : String!
    var leagues: [League] = []
    var leaguesViewModel: LeaguesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        sportName = defaults.value(forKey:"sportName") as? String
        table.delegate = self
        table.dataSource = self
        leaguesViewModel = LeaguesViewModel(sport: sportName.lowercased() )
        leaguesViewModel.sendArrayToViewController = {
            [weak self ] in
            DispatchQueue.main.async {
                self?.leagues = self?.leaguesViewModel.leagues ?? []
                self?.table.reloadData()
                
            }
        }
        leaguesViewModel.getData()
    }
    

    @IBAction func back_action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueViewCell
        
        cell.leagueName.text = leagues[indexPath.row].leagueName
        
        let url = URL(string: leagues[indexPath.row].leagueLogo ?? "")
        cell.leagueImage.kf.setImage(with: url,
                                     placeholder: UIImage(named: sportName ?? "fotball"))
        return cell
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let reachability = try! Reachability()
        if reachability.connection != .unavailable {
            let defaults = UserDefaults.standard
            defaults.setValue(leagues[indexPath.row].leagueKey ,forKey: "leagueID")
            defaults.setValue(leagues[indexPath.row].leagueName ,forKey: "leagueName")
            defaults.setValue(leagues[indexPath.row].leagueLogo ,forKey: "leagueLogo")
            self.performSegue(withIdentifier: "leagueDetails", sender: nil)
            
        } else {
            let alert : UIAlertController = UIAlertController(title: "Internet Connection", message: "Check connection and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    

}
