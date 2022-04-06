//
//  SignUpVC .swift
//  MDB Social
//
//  Created by David Ko on 3/29/22.
//

import Foundation
import UIKit
import NotificationBannerSwift

class SignUpVC: UIViewController {
    
    private var bannerQueue = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)
    
    let fullNameTab: AuthTextField = {
        let tf = AuthTextField(title: "Full Name:")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailTab: AuthTextField = {
        let tf = AuthTextField(title: "Email:")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let userNameTab: AuthTextField = {
        let tf = AuthTextField(title: "Username:")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passWordTab: AuthTextField = {
        let tf = AuthTextField(title: "Password:")
        tf.textField.isSecureTextEntry = true
        //tf.textField.isSecureTextEntry.toggle()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passWordConfirmTab: AuthTextField = {
        let tf = AuthTextField(title: "Confirm Password:")
        tf.textField.isSecureTextEntry = true
        //tf.textField.isSecureTextEntry.toggle()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let signUpButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = UIColor.primary.cgColor
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.isUserInteractionEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    let signInActionLabel: HorizontalActionLabel = {
        let actionLabel = HorizontalActionLabel(
            label: "Have an account already?",
            buttonTitle: "Sign In Here")
        
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        return actionLabel
    }()
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(fullNameTab)
        view.addSubview(emailTab)
        view.addSubview(userNameTab)
        view.addSubview(passWordTab)
        view.addSubview(passWordConfirmTab)
        view.addSubview(signUpButton)
        view.addSubview(signInActionLabel)
        
        hideKeyboardWhenTappedAround()
        NSLayoutConstraint.activate([
            fullNameTab.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            fullNameTab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            fullNameTab.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)])
        
        NSLayoutConstraint.activate([
            emailTab.topAnchor.constraint(equalTo: fullNameTab.topAnchor, constant: 80),
            emailTab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            emailTab.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)])
        
        NSLayoutConstraint.activate([
            userNameTab.topAnchor.constraint(equalTo: emailTab.topAnchor, constant: 80),
            userNameTab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            userNameTab.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)])
            
        NSLayoutConstraint.activate([
            passWordTab.topAnchor.constraint(equalTo: userNameTab.topAnchor, constant: 80),
            passWordTab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            passWordTab.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)])
        
        NSLayoutConstraint.activate([
            passWordConfirmTab.topAnchor.constraint(equalTo: passWordTab.topAnchor, constant: 80),
            passWordConfirmTab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            passWordConfirmTab.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)])
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passWordConfirmTab.topAnchor, constant: 80),
            signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)])

        NSLayoutConstraint.activate([
            signInActionLabel.topAnchor.constraint(equalTo: signUpButton.topAnchor, constant: 50),
            signInActionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            signInActionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)])
        
        
        signInActionLabel.addTarget(self, action: #selector(didTapSignIn(_:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyboardNotification(notification:)), name: UIResponder.keyboardFrameEndUserInfoKey, object: nil)
        
    }
    
    
    
    @objc private func didTapSignIn(_ sender: UIButton) {
        let vc = SigninVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc private func didTapSignUp(_ sender: UIButton) {
        signUpButton.showLoading()
        guard let name = fullNameTab.text, name != "" else {
            showErrorBanner(withTitle: "Missing full name", subtitle: "Please enter your full name")
            return
        }
        guard let email = emailTab.text, email != "" else {
            showErrorBanner(withTitle: "Missing email", subtitle: "Please enter an email")
            return
        }
        guard let userName = userNameTab.text, userName != "" else {
            showErrorBanner(withTitle: "Missing username", subtitle: "Please enter a username")
            return
        }

        guard let password = passWordTab.text, password != "" else {
            showErrorBanner(withTitle: "Missing password", subtitle: "Please enter a password")
            return
        }

        guard let confirmPassword = passWordConfirmTab.text, confirmPassword != "" else {
            showErrorBanner(withTitle: "Missing password confirmation", subtitle: "Please confirm your password")
            return
        }
        if passWordTab.text != passWordConfirmTab.text {
            showErrorBanner(withTitle: "Password does not match", subtitle: "Make sure password confirmation is correct")
        }
        
        
        AuthManager.shared.signUp(email: email, password: password, username: userName, name: name, completion: {
            [weak self] result in
            guard let self = self else { return }

            defer {
                self.signUpButton.hideLoading()
            }

            switch result {
            case .success:
                guard let window = self.view.window else { return }
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                window.rootViewController = vc
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)

            case .failure(let error):
                switch error {
                case .emailExists:
                    self.showErrorBanner(withTitle: "An account with this email already exists.", subtitle: "")
                case .weakPassword:
                    self.showErrorBanner(withTitle: "Password is too weak", subtitle: "Do better.")
                case .invalidEmail:
                    self.showErrorBanner(withTitle: "Not a valid email", subtitle: "Please check your email address")
                default:
                    self.showErrorBanner(withTitle: "Internal error", subtitle: "")
                }
            }
        })
        
        //self?.linkUser(withuid: authResult.user.uid, completion: completion)
        

    }
//
//    func checkPasswordConfirmation(password: )
    
    func showFeedNavigationVC() {
        let vc = FeedNavigationVC()
        present(vc, animated: true, completion: nil)
        
    }
    
    private func showErrorBanner(withTitle title: String, subtitle: String? = nil) {
        showBanner(withStyle: .warning, title: title, subtitle: subtitle)
    }
    
    private func showBanner(withStyle style: BannerStyle, title: String, subtitle: String?) {
        guard bannerQueue.numberOfBanners == 0 else { return }
        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle,
                                                titleFont: .systemFont(ofSize: 17, weight: .medium),
                                                subtitleFont: .systemFont(ofSize: 14, weight: .regular),
                                                style: style)
        
        banner.show(bannerPosition: .top,
                    queue: bannerQueue,
                    edgeInsets: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15),
                    cornerRadius: 10,
                    shadowColor: .primaryText,
                    shadowOpacity: 0.3,
                    shadowBlurRadius: 10)
    }
    
    
    
    
    @objc func didReceiveKeyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
            
        }
        guard let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        let curveRaw = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animateCurve = UIView.AnimationOptions(rawValue: curveRaw)
        
//        if endFrame.origin.y >= UIScreen.main.bounds.height {
//            bottomInsetConstraint.constant = contentEdgeInset.bottom //add NSLayoutconstraint
//        }
//        else {
//            bottomInsetConstraint.constant = endFrame.height + 10
            

        
//        UIView.animate(withDuration: duration, delay: 0, options: animateCurve, animations: {
//
//        }, completion
//
    }
    
    
}
    
    
    
    
        
    
    
    
    
    
    
    
    
