//
//  version.swift
//  boink
//
//  Created by Dylan Dang on 1/31/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit
import SwiftUI



//check for update availability
enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

func isUpdateAvailable() throws -> Bool {
    guard let info = Bundle.main.infoDictionary,
          
        let currentVersion = info["CFBundleShortVersionString"] as? String,
        let identifier = info["CFBundleIdentifier"] as? String,
        let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(identifier)") else {
        throw VersionError.invalidBundleInfo
    }
    
    let data = try Data(contentsOf: url)
    guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
        throw VersionError.invalidResponse
    }
    if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
        
        return needsUpdate(appVers: version, devVers: currentVersion)
        //return version != currentVersion
    }
    throw VersionError.invalidResponse
}

func needsUpdate(appVers:String, devVers:String)-> Bool{
    
    //debugging
    //print(appVers, devVers, devVers[devVers.index(devVers.startIndex, offsetBy: 0)], devVers[devVers.index(devVers.startIndex, offsetBy: 2)])
    if devVers[devVers.index(devVers.startIndex, offsetBy: 0)] > appVers[appVers.index(appVers.startIndex, offsetBy: 0)] || devVers[devVers.index(devVers.startIndex, offsetBy: 2)] > appVers[appVers.index(appVers.startIndex, offsetBy: 2)]{
        return false
    }
    
    //bug
    if devVers[devVers.index(devVers.startIndex, offsetBy: 0)] == appVers[appVers.index(appVers.startIndex, offsetBy: 0)] && devVers[devVers.index(devVers.startIndex, offsetBy: 2)] == appVers[appVers.index(appVers.startIndex, offsetBy: 2)]{
        return false
    }
    
    return true
}


func checkIfUpdateIsAvailable(self: UIViewController){
    DispatchQueue.global().async {
        do {
            let update = try isUpdateAvailable()
            DispatchQueue.main.async {
                print(update)
                if update{
                    addAlertController(self: self)
                }else{
                    print("System up to date!!!!!!!!!!")
                }
            }
        } catch {
            print(error)
        }
    }
}






func sendToUpdateLink(){

    if let url = URL(string: "https://apps.apple.com/us/app/boink-tap-to-play/id1602935130"){
        UIApplication.shared.open(url)
    }
    
}


func addAlertController(self:UIViewController){
    let alert = UIAlertController(title: "New Version", message: "Boink! has a new version available!", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Update", style: .default){ (action) in
        sendToUpdateLink()
    }
    
    alert.addAction(action)
    
    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
}
