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
   
        self.loadingView = UIActivityIndicatorView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.loadingView.color = UIColor.blue
        self.view.addSubview(self.loadingView)
        
        
    }
    
    func showLoadingView(){
        self.loadingView.startAnimating()
        self.loadingView.isHidden = false
    }
    
    func hideLoadingView(){
        self.loadingView.stopAnimating()
        self.loadingView.isHidden = true
    }

    
    func showAlertView(message: String){
        let alert = UIAlertController(title: "Test", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeCall(){
       
        
        //let tips = Tips(map: Map())
        
        //self.makeCall(tips)
        
      //  self.makeCallz()
        
        /*
        self.networkCall(
            successBlock: { tips in
                print(tips.name)
            }, errorBlock: { error in
                print(error)
            }, failureBlock: {
                print("Failure")
            }, plugins: [LoadingViewPlugin(viewController: self),
                         AlertViewPlugin(viewController: self)]
        )
        */
        
        
        self.networkCall(
            item: Tips.self,
            url: TipsAPI.getTips,
            successBlock: { tips in
                print(tips.name)
            }, errorBlock: { error in
                print(error)
            }, failureBlock: {
                print("Failure")
            }, plugins: [LoadingViewPlugin(viewController: self), AlertViewPlugin(viewController: self)]
        )

        self.networkCall(
            item: Operation.self,
            url: OperationAPI.getOperation,
            successBlock: { operation in
                print(operation.valeur)
            }, errorBlock: { error in
                print(error)
            }, failureBlock: {
                print("Failure")
            }, plugins: [LoadingViewPlugin(viewController: self), AlertViewPlugin(viewController: self)]
        )

        
    }
    
    
    
    func networkCall<T: SWGOutput>(
        item: T.Type,
        url: URLRequestConvertible,
        successBlock: @escaping (_ tips: T) -> (),
                     errorBlock: @escaping (_ errorMessage: String) -> (),
                     failureBlock: @escaping () -> (),
                     plugins: [Plugin] = [])
    {
        
    
        plugins.forEach({$0.willSendRequest()})
        
        Alamofire.request(url).responseObject {(response: DataResponse<T>) in
            
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
            } else {
                
                let resp = response.result.value
                if (resp?.error != nil) {
                    errorBlock((resp?.error!)!)
                } else {
                    // Success
                    successBlock(resp!)
                }
            }
   
            plugins.forEach({$0.requestDidFinished(statut: .success)})
        }
    }
}

enum IDPRequestStatut {
    case success
    case error(String)
    case network
}

protocol Plugin {
    
    
    func willSendRequest()
    func requestDidFinished(statut: IDPRequestStatut)
    
    
}

/// Default implementation so each method is optional
extension Plugin {

    func willSendRequest() {}
    func requestDidFinished(statut: IDPRequestStatut) {}
    
}

class LoadingViewPlugin: Plugin {
    
    let viewController: ViewController
    
    init(viewController: ViewController){
        self.viewController = viewController
    }
    
    func willSendRequest() {
        viewController.showLoadingView()
    }
    
    func requestDidFinished(statut: IDPRequestStatut) {
        viewController.hideLoadingView()
    }
}

class AlertViewPlugin: Plugin {
    
    let viewController: ViewController
    
    init(viewController: ViewController){
        self.viewController = viewController
    }
    
    func requestDidFinished(statut: IDPRequestStatut) {
    
        switch statut {
        case .error, .network:
            viewController.showAlertView(message: "YOLO")
        default: break
        }
    }
}

