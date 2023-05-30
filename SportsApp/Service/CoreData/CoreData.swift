//
//  CoreData.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import Foundation
import CoreData
import UIKit
class CoreData: CoreDataProtocol{
    
    var managedContext: NSManagedObjectContext
    init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    func insertLeague(league: LocalLeague) {
        let entity = NSEntityDescription.entity(forEntityName: "FavLeagues", in: managedContext)
        let leagueLocal = NSManagedObject(entity: entity!, insertInto: managedContext)
        leagueLocal.setValue(league.leagueKey, forKey: "leagueKey")
        leagueLocal.setValue(league.sportName, forKey: "sportName")
        leagueLocal.setValue(league.leagueName, forKey: "leagueName")
        leagueLocal.setValue(league.leagueLogo, forKey: "leagueLogo")
       
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("League is not inserted in fav: \(error)\n")
        }
    }
    
    func getFavLeagues() -> [LocalLeague] {
        var leaguesList: [LocalLeague] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeagues")
        do{
            let leagues = try managedContext.fetch(fetchRequest)
            for i in leagues{
                let l = LocalLeague(leagueKey: i.value(forKey: "leagueKey") as! Int,
                                    leagueName: i.value(forKey: "leagueName") as! String,
                                    sportName: i.value(forKey: "sportName") as! String ,
                                    leagueLogo: i.value(forKey: "leagueLogo") as! String)
                leaguesList.append(l)
            }
        }catch let error as NSError{
            print("All Local Leagues are not founded: \(error)")
        }
        
        return leaguesList
    }
    
    func deleteFavLeague(leagueName: String, leagueKey: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeagues")
        
        //let myPredicate = NSPredicate(format: "leagueKey == %d", leagueKey)
                let myPredicate = NSPredicate(format: "leagueName == %@ and leagueKey == %d", leagueName, leagueKey)
        fetchRequest.predicate = myPredicate
        do{
            let leagues = try managedContext.fetch(fetchRequest)
            print(leagues.count)
            if leagues.count > 0{
                managedContext.delete(leagues[0])
                try managedContext.save()
            }
        }catch let error as NSError{
            print("error in deleteting  league : \(error)")
        }
    }
    
    func getLeagueFromLocal(leagueName: String,leagueKey: Int) -> LocalLeague?{
        var leagueL: LocalLeague?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeagues")
        
        let myPredicate = NSPredicate(format: "leagueName == %@ and leagueKey == %d", leagueName, leagueKey)
        fetchRequest.predicate = myPredicate
        do{
            let leagues = try managedContext.fetch(fetchRequest)
            if leagues.count > 0{
                let i = leagues[0]
                leagueL = LocalLeague(leagueKey: i.value(forKey: "leagueKey") as! Int,
                                      leagueName: i.value(forKey: "leagueName") as! String,
                                      sportName: i.value(forKey: "sportName") as! String ,
                                      leagueLogo: i.value(forKey: "leagueLogo") as! String)
                                      
               
            }else{
                print("League is not found")
            }
        }catch let error as NSError{
            print("error in fetching all leagues: \(error)")
        }
        
        return leagueL ?? nil
    }
   
}
