//
//  AccountInformationViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.


import UIKit
import Parse
import AlamofireImage

class AccountInformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var userEmail:String = ""
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var interestField: UITextField!
    @IBOutlet weak var profileDescriptionField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func onConfirm(_ sender: Any) {
        let userInterests = interestField.text?.components(separatedBy: ", ")
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        UserDBHelper.initializeUserAccountInformation(email: userEmail, phoneNumber: phoneNumberField.text!, description: profileDescriptionField.text!, interests: userInterests!, profilePicture: file) {
            error in
            if let error = error {
                print(error)
            } else {
                self.performSegue(withIdentifier: "accountInfoToHome", sender: nil)
            }
        }
        
    }
    
    @IBAction func onUploadPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }
}
