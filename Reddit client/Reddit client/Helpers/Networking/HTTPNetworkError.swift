//
//  HTTPNetworkError.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

enum HTTPNetworkError: Error {

    case unknown
    case canceled
    case badUrl
    case timeOut
    case notReachedServer
    case incorrectDataReturned
    case notConnectedToInternet
    case connectionLost
    case internationalRoamingOff
    case parametersNil
    case headersNil
    case encodingFailed
    case decodingFailed
    case missingURL
    case couldNotParse
    case noData
    case success
    case authenticationError
    case badRequest
    case failed
    case serverSideError
    case unwrappingError

    init(error: NSError) {
        if error.domain == NSURLErrorDomain {
            switch error.code {
            case NSURLErrorUnknown:
                self = .unknown
            case NSURLErrorCancelled:
                self = .canceled
            case NSURLErrorBadURL:
                self = .badUrl
            case NSURLErrorTimedOut:
                self = .timeOut
            case NSURLErrorUnsupportedURL:
                self = .badUrl
            case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
                self = .notReachedServer
            case NSURLErrorDataLengthExceedsMaximum:
                self = .incorrectDataReturned
            case NSURLErrorNetworkConnectionLost:
                self = .connectionLost
            case NSURLErrorDNSLookupFailed:
                self = .notReachedServer
            case NSURLErrorHTTPTooManyRedirects:
                self = .unknown
            case NSURLErrorResourceUnavailable:
                self = .incorrectDataReturned
            case NSURLErrorNotConnectedToInternet:
                self = .notConnectedToInternet
            case NSURLErrorRedirectToNonExistentLocation, NSURLErrorBadServerResponse:
                self = .incorrectDataReturned
            case NSURLErrorUserCancelledAuthentication, NSURLErrorUserAuthenticationRequired:
                self = .unknown
            case NSURLErrorZeroByteResource, NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData:
                self = .incorrectDataReturned
            case NSURLErrorCannotParseResponse:
                self = .incorrectDataReturned
            case NSURLErrorInternationalRoamingOff:
                self = .internationalRoamingOff
            case NSURLErrorCallIsActive, NSURLErrorDataNotAllowed, NSURLErrorRequestBodyStreamExhausted:
                self = .unknown
            case NSURLErrorFileDoesNotExist, NSURLErrorFileIsDirectory:
                self = .incorrectDataReturned
            case NSURLErrorNoPermissionsToReadFile,
                 NSURLErrorSecureConnectionFailed,
                 NSURLErrorServerCertificateHasBadDate,
                 NSURLErrorServerCertificateUntrusted,
                 NSURLErrorServerCertificateHasUnknownRoot,
                 NSURLErrorServerCertificateNotYetValid,
                 NSURLErrorClientCertificateRejected,
                 NSURLErrorClientCertificateRequired,
                 NSURLErrorCannotLoadFromNetwork,
                 NSURLErrorCannotCreateFile,
                 NSURLErrorCannotOpenFile,
                 NSURLErrorCannotCloseFile,
                 NSURLErrorCannotWriteToFile,
                 NSURLErrorCannotRemoveFile,
                 NSURLErrorCannotMoveFile,
                 NSURLErrorDownloadDecodingFailedMidStream,
                 NSURLErrorDownloadDecodingFailedToComplete:
                self = .unknown
            default:
                self = .unknown
            }
        } else {
            self = .unknown
        }
        
    }
    
    var desc: String {
        switch self {
        case .authenticationError:
            return "You must be Authenticated"
        case .unknown:
            return "Unknown error"
        case .canceled:
            return "Cancel request"
        case .badUrl:
            return "The URL is incorrect"
        case .timeOut:
            return "Time out to connect server"
        case .notReachedServer:
            return "Unable to connect server"
        case .incorrectDataReturned:
            return "Invalid data returned from server"
        case .notConnectedToInternet:
            return "No internet connection"
        case .connectionLost:
            return "Lost connection to server"
        case .internationalRoamingOff:
            return "International data roaming disabled"
        case .parametersNil:
            return "Parameters are nil"
        case .headersNil:
            return "Headers are nil"
        case .encodingFailed:
            return "Parameter Encoding failed"
        case .decodingFailed:
            return "Unable to Decode the data"
        case .missingURL:
            return "The URL is nil"
        case .couldNotParse:
            return "Unable to parse the JSON response"
        case .noData:
            return "No data"
        case .success:
            return "Successful Network Request"
        case .badRequest:
            return "Bad Request"
        case .failed:
            return "Network request failed"
        case .serverSideError:
            return "Server error"
        case .unwrappingError:
            return "Unable to unwrapping the data"
        }
    }
    
}
