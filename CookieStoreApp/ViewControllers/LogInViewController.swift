    //
    //  LogInViewController.swift
    //  CookieStoreApp
    //
    //  Created by Kate Alyssa Joanna L. de Leon on 2/18/25.
    //

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }

        if let userIndex = SampleData.shared.users.firstIndex(where: { $0.username == username && $0.password == password }) {
            // Update current user
            SampleData.shared.currentUser = SampleData.shared.users[userIndex]
        } else {
            // Show error alert for invalid login
            showAlert(title: "Login Failed", message: "Invalid username or password. Please try again.")
        }
    }

    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        SampleData.shared.logout() // Clear user session on logout
    }

    // MARK: - Helper Function to Show Alerts
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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
