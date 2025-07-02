//
//  SalesHistoryViewController.swift
//  CookieStoreApp
//
//  Created by Kate Alyssa Joanna L. de Leon on 2/18/25.
//

import UIKit

class SalesHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var purchases: [Purchase] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        loadPurchases()
    }

    // Ensure purchases are reloaded every time the screen appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPurchases()
    }

    func loadPurchases() {
        // Load purchases for the currently logged-in user
        if let currentUser = SampleData.shared.currentUser {
            purchases = currentUser.purchaseHistory
        }
        
        tableView.reloadData() // Refresh Table View
    }

    // MARK: - Logout Button Action (Triggers Unwind Segue)
    @IBAction func logoutTapped(_ sender: UIButton) {
        
    }

    // MARK: - TableView Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalesHistoryCell", for: indexPath)
        let purchase = purchases[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = "\(purchase.cookieName) (\(purchase.type ?? "Regular"))"
        content.secondaryText = "Qty: \(purchase.quantity) | \(formattedDate(purchase.date))"
        cell.contentConfiguration = content

        return cell
    }
    
    // Helper function to format dates
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
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
