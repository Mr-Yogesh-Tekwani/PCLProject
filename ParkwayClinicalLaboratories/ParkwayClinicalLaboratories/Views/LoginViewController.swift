//
//  SignUpViewController.swift
//  GAP International
//
//  Created by Yogesh on 6/19/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginViewModel : LoginViewModel?
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var ians : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        let titleView = UIImageView (image: UIImage (named: "PCL"))
        titleView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.view.backgroundColor = .white
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.font = UIFont.systemFont(ofSize: 30)
        usernameTextField.layer.borderWidth = 3.0
        usernameTextField.layer.borderColor = UIColor.systemBlue.cgColor
        usernameTextField.borderStyle = .roundedRect
        
        self.view.addSubview(usernameTextField)
        
        // Create and position the password text field
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 30)
        passwordTextField.layer.borderWidth = 3.0
        passwordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
        
        // Create a sign-up button
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Login", for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        self.view.addSubview(signUpButton)
        
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            usernameTextField.heightAnchor.constraint(equalToConstant: 70),
            usernameTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            passwordTextField.heightAnchor.constraint(equalToConstant: 70),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250)
        ])
        
    }
    
    @objc func loginButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                  // Show an error message if any field is empty
                  showAlert(message: "Please fill in all fields.")
                  return
              }
        
        loginViewModel?.loginPressed(username: username, password: password, finalCompletion: { ans in
            
            DispatchQueue.main.async {
                
                if ans == true {
                    print("Login SUCCESS")
                    let svc = AdminHomeViewController()
                    svc.modalPresentationStyle = .fullScreen
                    
                    // Present the navigation controller modally
                    self.present(svc, animated: true, completion: nil)
                    
                }
                else {
                   
                    showAlert(message: "Something is Wrong!")
                }
            }
        })
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
