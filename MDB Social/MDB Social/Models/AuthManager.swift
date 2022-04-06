//
//  AuthManager.swift
//  MDB Social
//
//  Created by Michael Lin on 10/9/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager {
    
    static let shared = AuthManager()
    
    let auth = Auth.auth()
    
    enum SignInErrors: Error {
        case wrongPassword
        case userNotFound
        case invalidEmail
        case internalError
        case errorFetchingUserDoc
        case errorDecodingUserDoc
        case unspecified
    }
    
    enum SignUpErrors: Error {
        
        case invalidEmail
        case weakPassword
        case passWordNoMatch
        case unspecified
        case emailExists
        case errorFetchingUserDoc
        case errorDecodingUserDoc
    
    }
    
    let db = Firestore.firestore()
    
    var currentUser: User?
    
    private var userListener: ListenerRegistration?
    
    init() {
        guard let user = auth.currentUser else { return }
        
        linkUser(withuid: user.uid, completion: nil)
    }
    
    func signIn(withEmail email: String, password: String,
                completion: ((Result<User, SignInErrors>)->Void)?) {
        
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                let nsError = error as NSError
                let errorCode = FirebaseAuth.AuthErrorCode(rawValue: nsError.code)
                
                switch errorCode {
                case .wrongPassword:
                    completion?(.failure(.wrongPassword))
                case .userNotFound:
                    completion?(.failure(.userNotFound))
                case .invalidEmail:
                    completion?(.failure(.invalidEmail))
                default:
                    completion?(.failure(.unspecified))
                }
                return
            }
            guard let authResult = authResult else {
                completion?(.failure(.internalError))
                return
            }
            
            self?.linkUser(withuid: authResult.user.uid, completion: completion)
        }
    }
    
    /* TODO: Firebase sign up handler, add user to firestore */
    
    
    func signUp(email: String, password: String, username: String, name: String,
                completion: ((Result<User, SignUpErrors>)->Void)?) { //

        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let nsError = error as NSError
                let errorCode = FirebaseAuth.AuthErrorCode(rawValue: nsError.code)

                switch errorCode {
                case .invalidEmail:
                    completion?(.failure(.invalidEmail))
                case .weakPassword:
                    completion?(.failure(.weakPassword))
                case .emailAlreadyInUse:
                    completion?(.failure(.emailExists))
                default:
                    completion?(.failure(.unspecified))

                }
                return
            }
            
            self.linkUserSignUp(withuid: authResult!.user.uid, completion: completion)
            let user: User = User(uid: authResult?.user.uid, username: username, email: email, fullname: name, savedEvents: [])
            DatabaseRequest.shared.setUser(user, completion: {})
            


        }
        
        
    }
    
    
    func isSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signOut(completion: (()->Void)? = nil) {
        do {
            try auth.signOut()
            unlinkCurrentUser()
            completion?()
        } catch { }
    }
    
    private func linkUser(withuid uid: String,
                          completion: ((Result<User, SignInErrors>)->Void)?) {
        //attach listener --> listener is triggered
        userListener = db.collection("users").document(uid).addSnapshotListener { [weak self] docSnapshot, error in
            guard let document = docSnapshot else {
                completion?(.failure(.errorFetchingUserDoc))
                return
            }
            guard let user = try? document.data(as: User.self) else {
                completion?(.failure(.errorDecodingUserDoc))
                return
            }
            
            self?.currentUser = user
            completion?(.success(user))
        }
    }
    
    //created new link user function to account for SignUp Error enum i created
    private func linkUserSignUp(withuid uid: String, 
                          completion: ((Result<User, SignUpErrors>)->Void)?) {
        //attach listener --> listener is triggered
        userListener = db.collection("users").document(uid).addSnapshotListener { [weak self] docSnapshot, error in
            guard let document = docSnapshot else {
                completion?(.failure(.errorFetchingUserDoc))
                return
            }
            guard let user = try? document.data(as: User.self) else {
                completion?(.failure(.errorDecodingUserDoc))
                return
            }
            
            self?.currentUser = user
            completion?(.success(user))
        }
    }
    
    private func unlinkCurrentUser() {
        userListener?.remove()
        currentUser = nil
    }
}
