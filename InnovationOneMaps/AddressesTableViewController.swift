//
//  AddressesTableViewController.swift
//  InnovationOneMaps
//
//  Created by Matheus Henrique on 13/04/22.
//

import UIKit


class AddressTableViewController: UITableViewController {
    
    var Addresses: [Address] = []
    
    var selectedAddress: ((Address) -> Void)?
    
    override func viewDidLoad() {
         super.viewDidLoad()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Addresses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath)
        let address = Addresses[indexPath.row]
        
        cell.textLabel?.text = address.name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = Addresses[indexPath.row]
        selectedAddress!(address)
        self.navigationController?.popViewController(animated: true)
    }
    
}
