//
//  httpJob.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 13/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HttpJob: NSObject {
    //
    //  htttpJob.swift
    //  Auto-Gym_for_Members
    //
    //  Created by Marcio R. Rosemberg on 13/12/18.
    //  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
    //
    
        private var urlString:String
        private var parameters:Dictionary<String, String>
        private var lastError:String
        private var result:String
        private var contentType:String
        //internal var alamoFireManager : SessionManager?
        private var success:Bool
        private var timeout:Double
        
        override init(){
            urlString = ""
            parameters = [:]
            result = ""
            lastError = ""
            contentType = ""
            success = true
            timeout = 30
        }
        
        public func setURL(url:String){
            self.urlString = url
        }
        public func setParameters(param:Dictionary<String, String>){
            self.parameters = param
        }
        
        public func getResult()->String{
            return self.result
        }
        
        public func getLastError()->String{
            return self.lastError
        }
        
        public func getContentType()->String{
            return self.contentType
        }
        
        public func getTimeout()->Double{
            return self.timeout
        }
        
        public func setTimeout(timeout:Double){
            self.timeout = timeout
        }
        
        public func post()->Bool{
            alamofirePost()
            return self.success
        }
        
        public func get()->Bool{
            alamofireGet()
            return self.success
        }
        
        private func alamofirePost(){
            //let configuration = URLSessionConfiguration.default
            //configuration.timeoutIntervalForRequest = self.timeout
            //configuration.timeoutIntervalForResource = self.timeout
            //alamoFireManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request(self.urlString, method:.post, parameters: self.parameters)
                .validate(statusCode: 200..<300)
                .responseString{
                    response in
                    if response.result.isFailure {
                        if let err = response.error?.localizedDescription {
                            self.lastError = err
                            self.result = ""
                            self.success = false
                        }
                        
                    } else{
                        if let data = response.data, let dados = String(data: data, encoding: .utf8){
                            self.result = dados
                            self.lastError = ""
                            self.success = true
                            if let cType = response.response?.allHeaderFields["Content-Type"] as? String {self.contentType = cType
                                // use contentType here
                            }
                            
                        }
                    }
            }
        }//alamofirePost
        
        private func alamofireGet(){
            //let configuration = URLSessionConfiguration.default
            //configuration.timeoutIntervalForRequest = self.timeout
            //configuration.timeoutIntervalForResource = self.timeout
            //alamoFireManager = Alamofire.SessionManager(configuration: configuration)
            print(self.urlString)
            print(parameters)
            guard let url = URL(string: self.urlString) else{
                self.success=false
                self.lastError="Invalid URL passed"
                self.result = ""
                return
            }
            Alamofire.request(url, method:.get, parameters: ["cnpj": "86.801.826/0001-74"])
                .validate(statusCode: 200..<300)
                .responseString {
                    response in
                    if response.result.isFailure {
                        if let err = response.error?.localizedDescription {
                            self.lastError = err
                            self.result = ""
                            self.success = false
                        }
                        
                    } else{
                        if let data = response.data, let dados = String(data: data, encoding: .utf8){
                            self.result = dados
                            self.lastError = ""
                            self.success = true
                            if let cType = response.response?.allHeaderFields["Content-Type"] as? String {self.contentType = cType
                                // use contentType here
                            }
                            
                        }
                    }
            }
        }//alamofireGet
}
