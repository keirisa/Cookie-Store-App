//
//  ItemListViewController.swift
//  CookieStoreApp
//
//  Created by Kate Alyssa Joanna L. de Leon on 2/18/25.
//

import UIKit

class ItemListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var categorizedCookies: [String: [Cookie]] = [:]
    var sectionTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        categorizeCookies()
    }
    
    func categorizeCookies() {
        let cookies = SampleData.shared.cookies
        
        // Group cookies by their main category
        categorizedCookies = Dictionary(grouping: cookies, by: { $0.name })
        
        // Sort section titles
        sectionTitles = categorizedCookies.keys.sorted()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = sectionTitles[section]
        return categorizedCookies[category]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use the default subtitle style cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CookieCell", for: indexPath)
        
        let category = sectionTitles[indexPath.section]
        if let cookie = categorizedCookies[category]?[indexPath.row] {
            // Set the title (cookie name and type if available)
            cell.textLabel?.text = cookie.type != nil ? "\(cookie.name) (\(cookie.type!))" : cookie.name
            
            // Set the subtitle (price)
            cell.detailTextLabel?.text = String(format: "$%.2f", cookie.price)
            
            // Set the image
            cell.imageView?.image = UIImage(named: cookie.imageName)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = sectionTitles[indexPath.section]
        if let selectedCookie = categorizedCookies[category]?[indexPath.row] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let purchaseVC = storyboard.instantiateViewController(withIdentifier: "PurchaseViewController") as? PurchaseViewController {
                purchaseVC.cookie = selectedCookie // Pass the selected cookie
                navigationController?.pushViewController(purchaseVC, animated: true)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
