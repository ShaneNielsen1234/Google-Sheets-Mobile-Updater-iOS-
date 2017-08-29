//
//  updateSheet.swift
//  TestiOS
//
//  Created by Shane Nielsen on 8/24/17.
//  Copyright © 2017 Shane Nielsen. All rights reserved.
//

import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class updateSheet: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var userLocation: UITextField!
    @IBAction func updateSheetUser(_ sender: Any) {
        self.view.endEditing(true)
        updateSheet()
    }

    @IBOutlet weak var label: UITextView!
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheets]

    //private let driveService = GTLRDriveService()
    private let service = GTLRSheetsService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.service.authorizer = user.authentication.fetcherAuthorizer()
        }
    }
    
    // Display (in the UITextView) the names and majors of students in a sample
    // spreadsheet:
    // https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
    func updateSheet() {
        label.text = "Getting sheet data..."
        let spreadsheetId = "1Si947bEdeRHZDJGEWW29D-uzfZj7fufynwuc6danFSo" //"1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"
        
        //test code
        let valueRange = GTLRSheets_ValueRange.init()
        valueRange.values = [[userInput.text! as Any]]
        
        
        
        let range = userLocation.text //"A:B"
        let query = GTLRSheetsQuery_SpreadsheetsValuesUpdate
            .query(withObject:valueRange, spreadsheetId: spreadsheetId, range:range!)
        query.valueInputOption = "USER_ENTERED"
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
       )
    }
    
    // Process the response and display output
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                       finishedWithObject result : GTLRSheets_ValueRange,
                                       error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        label.text = "Cell updated!"
    }


    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
