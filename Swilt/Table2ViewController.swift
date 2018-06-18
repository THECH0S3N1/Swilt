//
//  TableViewController.swift
//  Swilt
//

import UIKit


var myIndex2 = 0
class Table2ViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell2.textLabel?.text = stories[indexPath.row]
        cell2.textLabel?.textColor = UIColor.magenta
        
        return cell2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex2 = indexPath.row
        
    }
}
