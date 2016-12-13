//
//  ReserveRoomViewController.swift
//  MeetingRooms
//
//  Created by J.Style on 2016. 10. 11..
//  Copyright © 2016년 J.Style. All rights reserved.
//

import UIKit

class ReserveRoomViewController: UITableViewController {

    @IBOutlet weak var hostNameField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var attendeesField: UITextField!
    
    @IBOutlet weak var equipmentField: UITextField!
    
    @IBOutlet weak var cateringSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newReservation() -> Reservation?{
        let reservation = Reservation()
        let host = hostNameField.text!
        
        if host.isEmpty{
            return nil
        }
        
        reservation.hostName = host
        reservation.date = datePicker.date
        
        if let equipmentArray = equipmentField.text?.characters.split(separator: ",").map(String.init){
            reservation.equipments = equipmentArray
        }
        
        reservation.catering = cateringSwitch.isOn
        
        return reservation
    }
    
    @IBAction func makeReservation(_ sender: AnyObject) {
        guard let reservation = newReservation() else{
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        switch self.presentingViewController{
        case let tabBarC as UITabBarController:
            if let navigationC = tabBarC.selectedViewController as? UINavigationController, let reservationListVC = navigationC.topViewController as? ReservationListViewController{
                reservationListVC.addNewItem(reservation)
            }
        case let navigationC as UINavigationController:
            if let reservationListVC = navigationC.topViewController as? ReservationListViewController{
                reservationListVC.addNewItem(reservation)
            }
        case let reservationListVC as ReservationListViewController:
            reservationListVC.addNewItem(reservation)
        default:
            break;
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelReservation(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ReserveDone"{
            guard let reservation = newReservation(), let reservationListVC = segue.destination as? ReservationListViewController else{
                return
            }
            
            reservationListVC.addNewItem(reservation)
        }
    }
}
