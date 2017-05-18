//
//  ViewController.swift
//  IOSFileManagement
//
//  Created by healer on 5/17/17.
//  Copyright © 2017 healer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var fileManagaer:FileManager?
    var documentDir:NSString?
    var filePath:NSString?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fileManagaer=FileManager.default
        let dirPaths:NSArray=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir=dirPaths[0] as? NSString
        print("path : \(String(describing: documentDir))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func createFile(_ sender: Any) {
        
        var error: NSError? = nil
        filePath=documentDir?.appendingPathComponent("file1.txt") as? NSString
        fileManagaer?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        
        filePath=documentDir?.appendingPathComponent("file2.txt") as NSString?
        fileManagaer?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File created successfully")
    }
    func showSuccessAlert(titleAlert:NSString,messageAlert:NSString)
    {
        let alert:UIAlertController=UIAlertController(title:titleAlert as String, message: messageAlert as String, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alert.addAction(okAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
    }
  
    @IBAction func createDirectory(_ sender: Any) {
        do {
            try filePath=documentDir?.appendingPathComponent("/folder1")as!  NSString
            try fileManagaer?.createDirectory(atPath: filePath! as String, withIntermediateDirectories: false, attributes: nil)
            try self.showSuccessAlert(titleAlert: "Success", messageAlert: "Directory created successfully")
        }
        catch {
            print(error)
        }
        
    }
    @IBAction func writeFile(_ sender: Any) {
        let content:NSString=NSString(string: "helllo how are you?")
        let fileContent:Data=content.data(using: String.Encoding.utf8.rawValue)!
        try? fileContent .write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("file1.txt")), options: [.atomic])
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content written successfully")

        
    }
    @IBAction func readFile(_ sender: Any) {
        filePath=documentDir?.appendingPathComponent("/file1.txt") as! NSString
        var fileContent:Data?
        fileContent=fileManagaer?.contents(atPath: filePath! as String)
        let str:NSString=NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "data : \(str)" as NSString)
        
    }
 
    @IBAction func copyFile(_ sender: Any) {
        do {
            let originalFile=documentDir?.appendingPathComponent("file1.txt")
            let copyFile=documentDir?.appendingPathComponent("copy.txt")
            try fileManagaer?.copyItem(atPath: originalFile!, toPath: copyFile!)
            try self.showSuccessAlert(titleAlert: "Success", messageAlert:"File copied successfully")
        }
        catch {
            print(error)
        }
        
    }
    @IBAction func moveFile(_ sender: Any) {
        do {
            let oldFilePath:String=documentDir!.appendingPathComponent("file1.txt") as String
            let newFilePath:String=documentDir!.appendingPathComponent("/folder1/file1.txt") as String
            try fileManagaer?.moveItem(atPath: oldFilePath, toPath: newFilePath)
          
            self.showSuccessAlert(titleAlert: "Success", messageAlert: "File moved successfully")
        }
        catch {
            print(error)
        }
        
    }
   
    @IBAction func filePermission(_ sender: Any) {
        filePath=documentDir?.appendingPathComponent("file1.txt") as NSString?
        var filePermissions:NSString = ""
        
        if((fileManagaer?.isWritableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions=filePermissions.appending("file is writable. ") as NSString
        }
        if((fileManagaer?.isReadableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions=filePermissions.appending("file is readable. ") as NSString
        }
        if((fileManagaer?.isExecutableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions=filePermissions.appending("file is executable.") as NSString
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "\(filePermissions)" as NSString)
            }
    @IBAction func directoryConstants(_ sender: Any) {
        do {
            var error: NSError? = nil
            let arrDirContent = try fileManagaer!.contentsOfDirectory(atPath: documentDir! as String)
            try self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content of directory \(arrDirContent)" as NSString)
        }
        catch {
            print(error)
        }
                }
    @IBAction func removeFile(_ sender: Any) {
        do {
            try filePath=documentDir?.appendingPathComponent("file1.txt") as NSString?
            try fileManagaer?.removeItem(atPath: filePath! as String)
            try self.showSuccessAlert(titleAlert: "Message", messageAlert: "File removed successfully.")}
        catch {
            print(error)
        }
    }
    @IBAction func equalityCheck(_ sender: Any) {
        let filePath1=documentDir?.appendingPathComponent("file1.txt")
        let filePath2=documentDir?.appendingPathComponent("file2.txt")
        
        if((fileManagaer? .contentsEqual(atPath: filePath1!, andPath: filePath2!)) != nil)
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are equal.")
        }
        else
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are not equal.")
        }
    }
}

