//
//  PurchaseViewController.swift
//  CookieStoreApp
//
//  Created by Kate Alyssa Joanna L. de Leon on 2/18/25.
//
import UIKit

class PurchaseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var cookieImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var buyButton: UIButton!
    
    var cookie: Cookie!
    var selectedType: String?
    var selectedQuantity: Int = 1
    var availableTypes: [Cookie] = [] // Store different variants of the same cookie

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self

        // Load all available types of this cookie
        availableTypes = SampleData.shared.cookies.filter { $0.name == cookie.name }

        // Ensure the first selected type matches the chosen cell from ItemListViewController
        if let exactCookie = availableTypes.first(where: { $0.type == cookie.type }) {
            selectedType = exactCookie.type
            cookie = exactCookie // Ensure the selected cookie object is the one matching the user's choice
        } else {
            selectedType = availableTypes.first?.type // Default to the first available type
        }

        updateImage()
        pickerView.reloadAllComponents()
        
        // Ensure the picker pre-selects the correct type and quantity
        if let typeIndex = availableTypes.firstIndex(where: { $0.type == selectedType }) {
            pickerView.selectRow(typeIndex, inComponent: 0, animated: false)
        }
        pickerView.selectRow(0, inComponent: availableTypes.count > 1 ? 1 : 0, animated: false)
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return availableTypes.count > 1 ? 2 : 1 // Two columns if multiple types exist
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0, availableTypes.count > 1 {
            return availableTypes.count // Show available types in first column
        } else {
            return cookie.inventory // Show quantity options in second column
        }
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0, availableTypes.count > 1 {
            return availableTypes[row].type ?? "Regular"
        } else {
            return "\(row + 1)" // Quantity selection
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0, availableTypes.count > 1 {
            selectedType = availableTypes[row].type
            cookie = availableTypes[row] // Update cookie reference
            updateImage() // Update the image when type is selected
        } else {
            selectedQuantity = row + 1
        }
    }

    // MARK: - Buy Button Action

    @IBAction func buyCookie(_ sender: UIButton) {
        let currentUser = SampleData.shared.currentUser!

        // Create a purchase object
        let purchase = Purchase(
            cookieName: cookie.name,
            type: selectedType ?? "Regular",
            quantity: selectedQuantity,
            date: Date()
        )

        // Update the user's purchase history
        var updatedUser = currentUser
        updatedUser.purchaseHistory.append(purchase)

        // Save the updated user back to SampleData
        if let userIndex = SampleData.shared.users.firstIndex(where: { $0.username == updatedUser.username }) {
            SampleData.shared.users[userIndex] = updatedUser
        }

        // Update the cookie inventory
        if let cookieIndex = SampleData.shared.cookies.firstIndex(where: { $0.name == cookie.name && $0.type == selectedType }) {
            SampleData.shared.cookies[cookieIndex].inventory -= selectedQuantity
        }

        // Update currentUser in SampleData
        SampleData.shared.currentUser = updatedUser

        // Show confirmation alert
        showAlert(title: "Purchase Successful!", message: "You bought \(purchase.quantity) x \(purchase.cookieName) (\(purchase.type ?? "Regular"))") {
            self.navigationController?.popViewController(animated: true) // Go back after confirmation
        }
    }

    // MARK: - Helper Function to Update Image
    func updateImage() {
        cookieImageView.image = UIImage(named: cookie.imageName)
    }

    // MARK: - Helper Function to Show Alerts
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?() // Execute completion after pressing OK
        }
        alert.addAction(okayAction)
        present(alert, animated: true)
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
