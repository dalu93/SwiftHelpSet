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
    
    public typealias PermissionCompletionHandler = Completion<Bool, NSError> -> ()
    
    /**
     Asks for the specific permission
     
     - parameter completion: The completion handler
     */
    public func ask(completion: PermissionCompletionHandler) {
        
        dispatch_async(dispatch_get_main_queue()) {
            switch self {
            case .library:
                self._askLibraryPermission(completion)
            case .camera:
                self._askCameraPermission(completion)
            }
        }
    }
}

// MARK: - Helpers
private extension Permission {
    
    func _askCameraPermission(completion: PermissionCompletionHandler) {
        
        switch AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) {
        case .Authorized: completion(.success(true))
        case .NotDetermined:
            AVCaptureDevice.requestAccessForMediaType(
                AVMediaTypeVideo,
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
    
    func _askLibraryPermission(completion: PermissionCompletionHandler) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .Authorized: completion(.success(true))
        case .NotDetermined:
            PHPhotoLibrary.requestAuthorization { authStatus in
                
                if authStatus == .Authorized {
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