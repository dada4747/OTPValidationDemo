//
//  FirebaseAuthService.swift
//  OTPValidationDemo
//
//  Created by admin on 11/06/22.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService {
    static let shared = FirebaseAuthService()
    private let auth = Auth.auth()
    typealias completionHandler = (Bool) -> Bool
    var verificationId : String?
    private init(){}
    
    func auth(phoneNumber: String, completion: @escaping completionHandler) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationId, error in
            if let error = error {
                print(error)}
//                completion(false)
                self.verificationId = verificationId
                UserDefaults.standard.set(verificationId, forKey: "authVerificationID")
//                completion(true)
                completion(true)
                print(verificationId)
        }
        
    }
    func veryfy(otpCode: String, completion: @escaping completionHandler){
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        
        let cred = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpCode)
        auth.signIn(with: cred) { result, error in
            guard result != nil , error == nil else {
                completion(false)
                return
            }
            completion(true)
        }

    }
    
}
