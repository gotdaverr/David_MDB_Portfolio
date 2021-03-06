//
//  DatabaseRequest.swift
//  MDB Social
//
//  Created by Michael Lin on 10/9/21.
//

import Foundation
import FirebaseFirestore

class DatabaseRequest {
    
    static let shared = DatabaseRequest()
    
    let db = Firestore.firestore()
    private var userListener: ListenerRegistration?
    
    func setUser(_ user: User, completion: (()->Void)?) {
        guard let uid = user.uid else { return }
        do {
            try db.collection("users").document(uid).setData(from: user) //db.collection user data base 
            completion?()
        }
        catch { }
    }
    
    func setEvent(_ event: Event, completion: (()->Void)?) {
        guard let id = event.id else { return }
        
        do {
            try db.collection("events").document(id).setData(from: event)
            completion?()
        } catch { }
    }
    
    /* TODO: Events getter */
    // For example, see SOCAuthManager.linkUser(withuid:completion:)
    
//    func eventGetter(withuid uid: String) {
//        db.collection("events").document(uid)
//
//
//    }
//
        func eventCount()-> Int {
            return db.collection("events").accessibilityElementCount()
        }
    
    func eventGet(vc: FeedVC)->[Event] {
        var events: [Event] = []
        if (AuthManager.shared.isSignedIn()) {
            userListener = db.collection("events").order(by: "startTimeStamp", descending: true).addSnapshotListener { querySnapshot, error in events = []
                guard let documents = querySnapshot?.documents else {
                    return
                }
                for document in documents {
                    guard let event = try? document.data(as: Event.self)
                    else {return}
                    events.append(event)
                }
            }
                
                                                                                        
        }
        return events
    }
    
}
