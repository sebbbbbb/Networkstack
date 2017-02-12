//
//  ViewController.swift
//  Networkstack
//
//  Created by Sebastien on 12/02/2017.
//  Copyright © 2017 Sebastien. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ViewController: UIViewController {

    var loadingView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func showLoadingView(){
        self.loadingView = UIActivityIndicatorView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.loadingView.color = UIColor.blue
        self.view.addSubview(self.loadingView)
        self.loadingView.startAnimating()
        
    }
    
    func hideLoadingView(){
        self.loadingView.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeCall(){
       
        
        //let tips = Tips(map: Map())
        
        //self.makeCall(tips)
        
      //  self.makeCallz()
        
        self.networkCall(
            successBlock: { tips in
                print(tips.name)
            }, errorBlock: { error in
                print(error)
            }, failureBlock: {
                print("Failure")
            }
        )
        
        
        
    }
    
    
    func makeCallz(){
        //let url = "http://localhost:8000/tips"
        let url = "http://46.101.228.22:3000/api/operations"
        
        
        Alamofire.request(url).responseObject {(response: DataResponse<Tips>) in
            
            let responseStatusCode = response.response?.statusCode
            
            if let error =  response.error {
                print(error._code)
                
                if error._code == -1001 || error._code == -1009 || error._code == -1004{
                    print("Network failure")
                }else {
                    
                    if let statusCode = responseStatusCode {
                        
                        if statusCode == 500 {
                            print("Server is fucked up")
                        } else if statusCode == 412 {
                            
                        }
                    }
                }
                return
            }
            
            
            
            let resp = response.result.value
            if (resp?.error != nil) {
                // Erreur
                print("200 with error")
            } else {
                // Success
                print("200 Success")
                
            }
      
        }
        
    }

    
    func networkCall(successBlock: @escaping (_ tips: Tips) -> (),
                     errorBlock: @escaping (_ errorMessage: String) -> (),
                     failureBlock: @escaping () -> ())
    {
        
    //    let url = "http://localhost:8000/tips"
        let url = "http://46.101.228.22:3000/api/operations"
        
        
        
        Alamofire.request(url).responseObject {(response: DataResponse<Tips>) in
            
            let responseStatusCode = response.response?.statusCode
            
            if let error =  response.error {
                print(error._code)
                
                if error._code == -1001 || error._code == -1009 || error._code == -1004{
                    print("Network failure")
                    failureBlock()
                }else {
                    
                    if let statusCode = responseStatusCode {
                        
                        if statusCode == 500 {
                            print("Server is fucked up")
                        } else if statusCode == 412 {
                            
                        }
                    }
                }
                return
            }
            
            
            
            let resp = response.result.value
            if (resp?.error != nil) {
                errorBlock((resp?.error!)!)
            } else {
                // Success
                successBlock(resp!)
            }
            
        }
        

        
        
    }
    

}

