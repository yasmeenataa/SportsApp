//
//  TeamViewController.swift
//  SportsApp
//
//  Created by Mac on 25/05/2023.
//

import UIKit

class TeamViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    

   
    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    var team : [Teams] = []
    var playersList : [Player] = []
    var teamDetailsViewModel: TeamDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        playersTable.delegate = self
        playersTable.dataSource = self
        let defaults = UserDefaults.standard
        let sportName = defaults.value(forKey:"sportName") as? String
        let teamId = defaults.value(forKey:"teamId") as? Int
        
        print (teamId ?? 5)
        print ("sport Name in team \(sportName ?? "")")
        
        teamDetailsViewModel = TeamDetailsViewModel()
        
        teamDetailsViewModel?.sendTeamToTeamViewController = {
            [weak self ] in
            DispatchQueue.main.async {
                self?.team = self?.teamDetailsViewModel?.teamList ?? []
                if self?.team.count != 0{
                    self?.teamName.text = self?.team[0].team_name
                    let url = URL(string: self?.team[0].team_logo ?? "")
                    self?.teamImage.kf.setImage(with: url,
                                               placeholder: UIImage(named: "noImg"))
                    self?.coachName.text = self?.team[0].coaches?[0].coach_name
                    self?.playersList = self?.team[0].players ?? []
                    self?.playersTable.reloadData()
                   
                }
            }
        }
        teamDetailsViewModel?.getTeamDetails(teamId: teamId!,sportName: sportName?.lowercased() ?? "football")
      
        }
        
    
    @IBAction func back_action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = playersList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersCell", for: indexPath)
        cell.textLabel?.text = player.player_name
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
}
