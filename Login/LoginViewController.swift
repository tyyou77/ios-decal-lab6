//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"

        static let buttonHeight: CGFloat = 100
        static let buttonMargin: CGFloat = 128
        static let buttonCornerRadius: CGFloat = 10
        static let buttonTextSize: CGFloat = 24
        static let buttonColor = UIColor.white
        static let viewColor = UIColor.red
        static let textColor = UIColor.red
        
        static let textSize: CGFloat = 20
        static let titleSize: CGFloat = 40
    
    }

    // TODO: instantiate the views needed for your project
    var myTitle: UILabel = {
        let myTitle = UILabel()
        myTitle.frame = CGRect(x: 0
, y: UIScreen.main.bounds.midY/4, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.2)
        myTitle.textColor = UIColor.yellow
        myTitle.font = UIFont(name: "Times New Roman", size: Constants.titleSize)
        myTitle.textAlignment = NSTextAlignment.center
        myTitle.text = "Login View Controller"
        return myTitle
    }()
    
    var myView: UIView = {
        let myView = UIView()
        myView.frame = CGRect(x: 0
            , y: UIScreen.main.bounds.midY/2, width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.height * 0.3)
        myView.backgroundColor = UIColor.white
        myView.layer.cornerRadius = Constants.buttonCornerRadius
        myView.layer.masksToBounds = true
        
        return myView
    }()
    
    var myId: UITextField = {
        let myId = UITextField()
        myId.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.05, y: (UIScreen.main.bounds.midY/2 - UIScreen.main.bounds.size.height * 0.24), width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.08)
        myId.placeholder = "Enter your email"
        myId.font = UIFont(name: "Times New Roman", size: Constants.textSize)
        myId.borderStyle = UITextBorderStyle.roundedRect
        myId.autocorrectionType = UITextAutocorrectionType.no
        myId.keyboardType = UIKeyboardType.default
        myId.returnKeyType = UIReturnKeyType.done
        myId.textAlignment = NSTextAlignment.center
        return myId
    }()
    
    var myPw: UITextField = {
        let myPw = UITextField()
        myPw.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.05, y: (UIScreen.main.bounds.midY/2 - UIScreen.main.bounds.size.height * 0.14), width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.08)
        myPw.placeholder = "Enter password"
        myPw.font = UIFont(name: "Times New Roman", size: Constants.textSize)
        myPw.borderStyle = UITextBorderStyle.roundedRect
        myPw.autocorrectionType = UITextAutocorrectionType.no
        myPw.keyboardType = UIKeyboardType.default
        myPw.returnKeyType = UIReturnKeyType.done
        myPw.textAlignment = NSTextAlignment.center
        return myPw
    }()
    
    var myButton: UIButton = {
        // first create a button to be returned by the closure
        let myButton = UIButton()
        
        let buttonWidth: CGFloat = UIScreen.main.bounds.size.width * 0.6
        myButton.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.05, y: (UIScreen.main.bounds.midY/2 - UIScreen.main.bounds.size.height * 0.04), width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.08)
        
        myButton.setTitle("Login", for: .normal)
        myButton.titleLabel?.font = UIFont(name: "Times New Roman", size: Constants.buttonTextSize)
        myButton.titleLabel?.numberOfLines = 2
        myButton.titleLabel?.textAlignment = .center
        myButton.setTitleColor(UIColor.yellow, for: .normal)
        
        // configure button itself
        myButton.backgroundColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        // makes the corners of the cell rounded, instead of squared off
        myButton.layer.cornerRadius = Constants.buttonCornerRadius
        myButton.layer.masksToBounds = true
        
        myButton.addTarget(self, action: #selector(authenticate), for: .touchDown)
        
        return myButton
    }()
    
    var myImageView: UIImageView = {
        let myImageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.1
            , y: UIScreen.main.bounds.midY * 4/3, width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.3))
        myImageView.image = UIImage(named: "oskibear")
        return myImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        // TODO: layout your views using frames or AutoLayout
        myView.center = view.center
        
        // IMPORTANT: this adds our button to the view. If you do not call this,
        // the button will never show up on the screen
        self.view.addSubview(myTitle)
        self.view.addSubview(myView)
        myView.addSubview(myId)
        myView.addSubview(myPw)
        myView.addSubview(myButton)
        self.view.addSubview(myImageView)
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func authenticate(sender: UIButton) {
        authenticateUser(username: myId.text, password: myPw.text)
    }
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
