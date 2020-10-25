//
//  conection.swift
//  PrubaGDC_Rene
//
//  Created by Giovanni Preza on 10/25/20.
//

import Foundation
import SwiftHTTP

class HTTPService {

    func makeRequest(params: [String: Any], successBlock: () -> Void, failureBlock: () -> Void) {
        HTTP.GET("https://www.host.com/example",requestSerializer: JSONParameterSerializer()) {
            response in
            if let err = response.error {
               print(err.localizedDescription)
               failureBlock() // Call failure block
               return
            } else {
               successBlock() // Call success block
            }
        }
     catch let err as NSError {
                        print(err)
    failureBlock() // Call failure block

                    }
    }


}
