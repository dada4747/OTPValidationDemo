//
//  ViewController.swift
//  OTPValidationDemo
//
//  Created by admin on 10/06/22.
//

import UIKit

class ViewController: UIViewController, Authentication {
    let headerColorView : UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemPink
        return uv
        
    }()
    let textFieldUIView : UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemBackground
        uv.layer.cornerRadius = 10
        uv.layer.cornerCurve = .circular
        
        uv.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        uv.layer.borderWidth = 3
        return uv
    }()
    let textField = CustomTextView(placeholder: "MobileNumber", fontSize: 25, keyboardType: .numberPad)
    let label = TitleLabel(textAlignment: .center, fontSize: 25)
    let signUpLabel = TitleLabel(textAlignment: .center, fontSize: 17)
    let submitButton = CustomButton(backgroundColor: .systemPink, title: "Submit")
    var descriptionBottomConstraints: NSLayoutConstraint!
    var keyboardHeight: CGFloat = 0.0


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil
        )
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        hideKeyboardWhenTappedAround()

    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func configureUI(){
        view.addSubview(headerColorView)
        headerColorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerColorView.topAnchor.constraint(equalTo: view.topAnchor),
            headerColorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerColorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerColorView.heightAnchor.constraint(equalToConstant:
                                                        (view.layer.frame.height / 2) - 50)
        ])
        view.addSubview(textFieldUIView)
        textFieldUIView.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
            textFieldUIView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            textFieldUIView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            textFieldUIView.heightAnchor.constraint(equalToConstant: 250),
            
        ])
        descriptionBottomConstraints =            textFieldUIView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        descriptionBottomConstraints.isActive = true

        textFieldUIView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: textFieldUIView.leftAnchor ,constant: 30),
            textField.rightAnchor.constraint(equalTo: textFieldUIView.rightAnchor, constant: -30),
            textField.bottomAnchor.constraint(equalTo: textFieldUIView.bottomAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        textFieldUIView.addSubview(label)
        label.text = "Enter Mobile Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: textFieldUIView.leftAnchor ,constant: 30),
            label.rightAnchor.constraint(equalTo: textFieldUIView.rightAnchor, constant: -30),
            label.topAnchor.constraint(equalTo: textFieldUIView.topAnchor, constant: 50),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(signUpLabel)
        signUpLabel.text = "Sign Up"
        signUpLabel.isUserInteractionEnabled = true
//        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.gotoHome))
//        signUpLabel.addGestureRecognizer(labelTapGesture)

        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
            signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor ,constant: 50),
            signUpLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            signUpLabel.topAnchor.constraint(equalTo: textFieldUIView.bottomAnchor, constant: 50),
            signUpLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(gotoOTP), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        submitButton.leftAnchor.constraint(equalTo: view.leftAnchor ,constant: 50),
        submitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
        submitButton.heightAnchor.constraint(equalToConstant: 50),
        submitButton.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 50),
        ])
        
    }
    @objc func gotoOTP(){
        let number = "+91\(textField.text!)"
        FirebaseAuthService.shared.auth(phoneNumber: number) {[weak self] success in
            guard success else { return false }
            DispatchQueue.main.async {
                let vc = OTPViewController()
                vc.delegate = self
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
                }
                        return true

        }

    }
    @objc func gotoHome(){
        self.dismiss(animated: true)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue             = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle                 = keyboardFrame.cgRectValue
            self.keyboardHeight                   = keyboardRectangle.height
            descriptionBottomConstraints.isActive = false
            descriptionBottomConstraints =            textFieldUIView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(keyboardHeight - 80))
             descriptionBottomConstraints.isActive = true
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        descriptionBottomConstraints.isActive = false
        descriptionBottomConstraints =            textFieldUIView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)

         descriptionBottomConstraints.isActive = true
    }
}

extension ViewController : UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        return self.textLimit(existingText: textView.text,
                              newText: text,
                              limit: 10)
    }
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
}
