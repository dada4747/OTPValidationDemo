//
//  OTPViewController.swift
//  OTPValidationDemo
//
//  Created by admin on 11/06/22.
//

import UIKit
protocol Authentication {
    func gotoHome()

}
class OTPViewController: UIViewController, OTPDelegate {
    func didChangeValidity(isValid: Bool) {
//        submitButton.isHidden = !isValid
        submitButton.backgroundColor = !isValid ? #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    
    var delegate : Authentication?
    let otpStackView = OTPStackView()
    let headerColorView : UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemPink
//        ui
        return uv
        
    }()
    var keyboardHeight: CGFloat = 0.0
    let textFieldUIView : UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemBackground
        uv.layer.cornerRadius = 10
        uv.layer.cornerCurve = .circular
        
        uv.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        uv.layer.borderWidth = 3
        return uv
    }()
//    let textField = CustomTextView(placeholder: "Enter OTP", fontSize: 25, keyboardType: .numberPad)
    let label = TitleLabel(textAlignment: .center, fontSize: 25)
    let goToLoginLabel = TitleLabel(textAlignment: .center, fontSize: 17)
    
    let submitButton = CustomButton(backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), title: "Login")
    var descriptionBottomConstraints: NSLayoutConstraint!

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
        
//        descriptionBottomConstraints
        view.addSubview(textFieldUIView)
        textFieldUIView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldUIView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            textFieldUIView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            textFieldUIView.heightAnchor.constraint(equalToConstant: 250),
            
        ])
        descriptionBottomConstraints =            textFieldUIView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        descriptionBottomConstraints.isActive = true

        textFieldUIView.addSubview(otpStackView)
        otpStackView.translatesAutoresizingMaskIntoConstraints = false
        otpStackView.delegate = self
        NSLayoutConstraint.activate([
            otpStackView.leftAnchor.constraint(equalTo: textFieldUIView.leftAnchor ,constant: 30),
            otpStackView.rightAnchor.constraint(equalTo: textFieldUIView.rightAnchor, constant: -30),
            otpStackView.bottomAnchor.constraint(equalTo: textFieldUIView.bottomAnchor, constant: -50),
            otpStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
//        textFieldUIView.addSubview(textField)
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.delegate = self
//        NSLayoutConstraint.activate([
//            textField.leftAnchor.constraint(equalTo: textFieldUIView.leftAnchor ,constant: 30),
//            textField.rightAnchor.constraint(equalTo: textFieldUIView.rightAnchor, constant: -30),
//            textField.bottomAnchor.constraint(equalTo: textFieldUIView.bottomAnchor, constant: -50),
//            textField.heightAnchor.constraint(equalToConstant: 50)
//        ])
        textFieldUIView.addSubview(label)
        label.text = "Enter Otp"
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: textFieldUIView.leftAnchor ,constant: 30),
            label.rightAnchor.constraint(equalTo: textFieldUIView.rightAnchor, constant: -30),
            label.topAnchor.constraint(equalTo: textFieldUIView.topAnchor, constant: 50),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(goToLoginLabel)
        goToLoginLabel.text = "back to login"
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.gotoLogin))

        goToLoginLabel.addGestureRecognizer(labelTapGesture)
        goToLoginLabel.isUserInteractionEnabled = true
//        forgotLabel.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(gotoLogin)))
        goToLoginLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
            goToLoginLabel.leftAnchor.constraint(equalTo: view.leftAnchor ,constant: 50),
            goToLoginLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            goToLoginLabel.topAnchor.constraint(equalTo: textFieldUIView.bottomAnchor, constant: 50),
            goToLoginLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        view.addSubview(submitButton)
//        submitButton.isHidden = true
//        submitButton.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        submitButton.addTarget(self, action: #selector(gotohome), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        submitButton.leftAnchor.constraint(equalTo: view.leftAnchor ,constant: 50),
        submitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
        submitButton.heightAnchor.constraint(equalToConstant: 50),
        submitButton.topAnchor.constraint(equalTo: goToLoginLabel.bottomAnchor, constant: 50),
        ])
    }
    @objc func gotoLogin(){
        print("tabe back to login ")
        dismiss(animated: true)
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
    @objc func gotohome(){
        FirebaseAuthService.shared.veryfy(otpCode: otpStackView.getOTP()) { success in
            guard success else {return false}
            DispatchQueue.main.async {
                self.dismiss(animated: true)
                self.delegate?.gotoHome()
            }
            return true
        }
        
    }
}

extension OTPViewController : UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        return self.textLimit(existingText: textView.text,
                              newText: text,
                              limit: 6)
    }
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
}
