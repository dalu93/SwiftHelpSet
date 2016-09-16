//
//  Permission.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/19/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

import AVFoundation
import Photos

/**
 Helps you to easily ask permissions for library and camera
 */
public enum Permission {
    case library
    case camera
    
    public typealias PermissionCompletionHandler = (Completion<Bool>) -> ()
    
    /**
     Asks for the specific permission
     
     - parameter completion: The completion handler
     */
    public func ask(completion: @escaping PermissionCompletionHandler) {
        
        DispatchQueue.main.async {
            switch self {
            case .library:
                self._askLibraryPermission(completion: completion)
            case .camera:
                self._askCameraPermission(completion: completion)
            }
        }
    }
}

// MARK: - Helpers
private extension Permission {
    
    func _askCameraPermission(completion: @escaping PermissionCompletionHandler) {
        
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .authorized: completion(.success(true))
        case .notDetermined:
            AVCaptureDevice.requestAccess(
                forMediaType: AVMediaTypeVideo,
                completionHandler: { granted in
                    
                    if granted {
                        completion(.success(true))
                    } else {
                        completion(.failed(.noAuthorizedError))
                    }
                }
            )
        default: completion(.failed(.noAuthorizedError))
        }
    }
    
    func _askLibraryPermission(completion: @escaping PermissionCompletionHandler) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized: completion(.success(true))
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { authStatus in
                
                if authStatus == .authorized {
                    completion(.success(true))
                } else {
                    completion(.failed(.noAuthorizedError))
                }
            }
        default: completion(.failed(.noAuthorizedError))
        }
    }
}

// MARK: - No authorized error
private extension NSError {
    static var noAuthorizedError: NSError {
        return NSError(
            domain: "Permission",
            code: -1,
            userInfo: [
                NSLocalizedDescriptionKey : "The user hasn't authorized the app"
            ]
        )
    }
}
