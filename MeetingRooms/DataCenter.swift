//
//  DataCenter.swift
//  MeetingRooms
//
//  Created by J.Style on 2016. 10. 11..
//  Copyright © 2016년 J.Style. All rights reserved.
//

import Foundation

let dataCenter: DataCenter = DataCenter()
let fileName = "BranchData.dat"

class DataCenter{
    var branches: [Branch] = []
    
    var filePath: String{
        get{
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            return documentDirectory + fileName
        }
    }
    
    init(){
        if FileManager.default.fileExists(atPath: self.filePath){
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Branch]{
                branches += unarchArray
            }
        }
        else{
            branches += defaultData()
        }
    }
    
    func save(){
        NSKeyedArchiver.archiveRootObject(self.branches, toFile: self.filePath)
    }
    
    func defaultData() -> Array<Branch>{
        let banskyRoom = MeetingRoom(name: "Bansky", capacity: 4)
        let kahloRoom = MeetingRoom(name: "Kahlo", capacity: 8)
        let riveraRoom = MeetingRoom(name: "Rivera", capacity: 8)
        let picassoRoom = MeetingRoom(name: "Picasso", capacity: 10)
        
        let vehicleService = Service(name: "차량예약")
        let meetingRoomService = Service(name: "회의실예약")
        let visitorService = Service(name: "방문자예약")
        let deskService = Service(name: "데스크예약")
        
        meetingRoomService.items = [banskyRoom, kahloRoom, riveraRoom, picassoRoom]
        
        let pangyoBranch = Branch(name: "판교점")
        let samsungBranch = Branch(name: "삼성점")
        let yeoksamBranch = Branch(name: "역삼점")
        let sinrimBranch = Branch(name: "신림점")
        let songdoBranch = Branch(name: "송도점")
        let anamBranch = Branch(name: "안암점")
        
        pangyoBranch.services = [vehicleService, meetingRoomService, visitorService, deskService]
        
        return [pangyoBranch, samsungBranch, yeoksamBranch, sinrimBranch, songdoBranch, anamBranch]
    }
}

class Branch: NSObject, NSCoding{
    let name: String
    var services: [Service]?
    
    init(name: String){
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.services = aDecoder.decodeObject(forKey: "services") as? [Service]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.services, forKey: "services")
    }
}

class Service: NSObject, NSCoding{
    let name: String
    var items: [MeetingRoom]?
    
    init(name: String){
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.items = aDecoder.decodeObject(forKey: "items") as? [MeetingRoom]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.items, forKey: "items")
    }
}

class MeetingRoom: NSObject, NSCoding{
    let name: String
    let capacity: Int
    var reservations: [Reservation]?
    
    init(name: String, capacity: Int){
        self.name = name
        self.capacity = capacity
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.capacity = aDecoder.decodeInteger(forKey: "capacity")
        self.reservations = aDecoder.decodeObject(forKey: "reservations") as? [Reservation]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.capacity, forKey: "capacity")
        aCoder.encode(self.reservations, forKey: "reservations")
    }
}

class Reservation: NSObject, NSCoding{
    var hostName: String
    var date: Date
    var attendees: Int
    var equipments: [String]
    var catering: Bool
    
    override init(){
        self.hostName = "Host of Meeting"
        self.date = Date()
        self.attendees = 1
        self.equipments = []
        self.catering = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.hostName = aDecoder.decodeObject(forKey: "hostName") as! String
        self.date = aDecoder.decodeObject(forKey: "date") as! Date
        self.attendees = aDecoder.decodeInteger(forKey: "attendees")
        self.equipments = aDecoder.decodeObject(forKey: "equipments") as! [String]
        self.catering = aDecoder.decodeBool(forKey: "catering")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.hostName, forKey: "hostName")
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.attendees, forKey: "attendees")
        aCoder.encode(self.equipments, forKey: "equipments")
        aCoder.encode(self.catering, forKey: "catering")
    }
}
