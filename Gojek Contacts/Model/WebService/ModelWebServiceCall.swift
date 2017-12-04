//
//  ModelWebServiceCall.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 28/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit
protocol WebServiceReturnDelegate {
    func jsonData(_ dataFromServer:Any)
    func setImageDownloadedFromURL(_ imageFile:UIImage, imageViewContact:UIImageView, stringImageLink:String)
}

class ModelWebServiceCall: NSObject,URLSessionDelegate {
    let httpGET = "GET"
    let httpPOST = "POST"
    
    var delegate:WebServiceReturnDelegate?
    
    func callRESTAPI(stringAPIURL:String, stringHTTPMethod:String){
        let urlAPI = URL(string:stringAPIURL)
        if let usableUrl = urlAPI {
            var request = URLRequest(url: usableUrl)
            request.httpMethod = stringHTTPMethod
            let urlConfig = URLSessionConfiguration.default
            urlConfig.timeoutIntervalForRequest = 10
            urlConfig.timeoutIntervalForResource = 10
            let sessionAPI = URLSession(configuration: urlConfig, delegate: self, delegateQueue: nil)
            _ = sessionAPI.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    if error?._code == -1001 {
                        //Domain=NSURLErrorDomain Code=-1001 "The request timed out."
                    }
                }
                else{
                    if let dataReturn = data {
                        if String(data: dataReturn, encoding: String.Encoding.utf8) != nil {
                            if let httpRes = response as? HTTPURLResponse {
                                //let stringResponseMessage = httpRes.description
                                if (httpRes.statusCode == 200){
                                    do {
                                        let jsonReturn = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
                                        self.delegate?.jsonData(jsonReturn as Any)
                                    } catch {
                                        print("error")
                                    }
                                }
                                else{
                                    //error
                                    //parse the error message
                                }
                            }
                        }
                    }
                }
            }.resume()
        }
    }
    
    func loadImageFromURL(link:String, imageview:UIImageView)
    {
        let stringImageFullPath:String = link
        let encoded = stringImageFullPath.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url:NSURL = NSURL(string: encoded!)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.timeoutInterval = 10
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                return
            }
            
            let image = UIImage(data: data!)
            
            if (image != nil)
            {
                DispatchQueue.main.async{
                    self.self.delegate?.setImageDownloadedFromURL(image!, imageViewContact:imageview, stringImageLink:link)
                }
            }
        }
        task.resume()
    }
}
