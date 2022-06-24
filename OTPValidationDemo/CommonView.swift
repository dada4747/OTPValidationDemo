//
//  CommonView.swift
//  OTPValidationDemo
//
//  Created by admin on 11/06/22.
//

import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    // MARK: - configure label
    private func configure() {
        textAlignment = .center
        textColor = .secondaryLabel
//        font = UIFont.systemFont(ofSize: 25)
//        text = "Enter Mobile Number"
        shadowOffset = CGSize(width: 1, height: 1)
        shadowColor = .tertiaryLabel
        adjustsFontSizeToFitWidth                 = true
        minimumScaleFactor                        = 0.9
        lineBreakMode = NSLineBreakMode.byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines                             = 1
    }
}

class CustomButton: UIButton {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        backgroundColor = .systemPink
        titleLabel?.textColor = .systemBackground
        layer.cornerRadius = 25
        layer.cornerCurve = .circular
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}


class CustomTextView: UITextView {


    // MARK: - Default Initializer
    convenience init(placeholder: String, fontSize: CGFloat, keyboardType: UIKeyboardType) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize)
        configure()
    }
     
    
    func configure(){
        isEditable = true
        textAlignment = .center// .natural
        keyboardType = .numberPad
        textColor = .label
        font =  UIFont.systemFont(ofSize: 25)
        layer.shadowOpacity = 1//0.5
        layer.borderWidth = 0.6
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        isUserInteractionEnabled = true
        textContainer.maximumNumberOfLines = 0
        backgroundColor             = .secondarySystemBackground
        isSelectable                = true
        isUserInteractionEnabled    = true
        tintColor                   = .label
        returnKeyType               = .done
        layer.masksToBounds         = true
        layer.cornerRadius          = 10.0
        textColor                   = .label
        dataDetectorTypes           = UIDataDetectorTypes.all
        layer.shadowOpacity         = 0.5
    }
}
