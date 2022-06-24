//
//  HomeViewController.swift
//  OTPValidationDemo
//
//  Created by admin on 11/06/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
//import Firebase

class HomeViewController: UIViewController {
    let logoutButton = CustomButton(backgroundColor: .systemPink, title: "Logout")

    override func viewDidLoad() {
        super.viewDidLoad()
       
        checkAuthentication()
        // Do any additional setup after loading the view.
    }
    func checkAuthentication(){
        if Auth.auth().currentUser?.uid != nil {
            configureHome()
        } else{
            showLoginScreen()
        }
    }
    func showLoginScreen(){
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController?.present(vc, animated: true)
    }
    func configureHome(){
        view.backgroundColor = .systemCyan
        navigationController?.title = "Home"
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor ,constant: 50),
        logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
        logoutButton.heightAnchor.constraint(equalToConstant: 50),
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        submitButton.topAnchor.constraint(equalTo: forgotLabel.bottomAnchor, constant: 50),
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAuthentication()
    }
    @objc func logout(){
        let firebaseAuth = Auth.auth()
       do {
         try firebaseAuth.signOut()
           showLoginScreen()
       } catch let signOutError as NSError {
         print("Error signing out: %@", signOutError)
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
