//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Hasan Basri Komser on 23.03.2023.
//

import UIKit

class ViewController: UITableViewController {
    var petititons = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(findPetition))
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
            showError()
    }
    @objc func showCredit() {
        var message: String!
        if navigationController?.tabBarItem.tag == 0 {
            message = "The data comes from the We The People API (recent) of the Whitehouse."
        } else {
            message = "The data comes from the We The People API (rated) of the Whitehouse."
        }
        let ac = UIAlertController(title: "Attention!", message: message , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac,animated: true)
    }
    @objc func findPetition(){
        let alert = UIAlertController(title: "Find", message:  "Enter the petition you want to find", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Find", style: .default,handler: nil))
        self.present(alert, animated: true)
    }
   
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petititons = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loadin Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petititons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petiton = petititons[indexPath.row]
        cell.textLabel?.text = petiton.title
        cell.detailTextLabel?.text = petiton.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petititons[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
