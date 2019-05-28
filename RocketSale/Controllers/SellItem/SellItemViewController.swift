//
//  SellItemViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class SellItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UITextField!
    @IBOutlet weak var productPriceLabel: UITextField!
    @IBOutlet weak var productBlurbLabel: UITextView!
    @IBOutlet weak var productTagsLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundFieldCorners()
    }
    
    //MARK: Styling methods
    func roundFieldCorners() {
        productBlurbLabel.layer.cornerRadius = 5
        productBlurbLabel.layer.masksToBounds = true
        productImageView.layer.cornerRadius = 5
        productBlurbLabel.layer.masksToBounds = true
    }
    
    //MARK: Database interaction methods
    func createNewProductForSale(name: String, blurb: String, price: Double, picture: PFFileObject?, tags: [String]?) {
        ProductDBHelper.createNewProduct(name: name, blurb: blurb, price: price, picture: picture, tags: tags) {
            error in
            if let error = error {
                print(error)
            } else {
                self.dismiss(animated: true, completion: nil)
                print("yep saved a new product")
            }
        }
    }
    
    //MARK: Interactivity methods
    @IBAction func onCancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostTap(_ sender: Any) {
        if validateFormInputs(name: productNameLabel.text!, blurb: productBlurbLabel.text!, priceString: productPriceLabel.text!, tagString: productTagsLabel.text!) {
            
            let productName = productNameLabel.text!
            let productBlurb = productBlurbLabel.text!
            let productPrice = convertCurrencyToDouble(currency: productPriceLabel.text!)
            let productTags = convertStringToArray(string: productTagsLabel.text!)
            let productImage = prepareProductImage()
            createNewProductForSale(name: productName, blurb: productBlurb, price: productPrice, picture: productImage, tags: productTags)
        } else {
            //TODO: Refactor into a shared view
            let alertController = UIAlertController(title: "DayTrip", message:
                "Inputs cannot be empty. Price must be in the proper format", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onImageTap(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    //ImagePicker methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        productImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Helper methods
    func convertCurrencyToDouble(currency: String) -> Double {
        let usLocale = Locale(identifier: "en_US")
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = usLocale
        let number = formatter.number(from: currency)
        return number as! Double
    }
    
    func convertStringToArray(string: String) -> [String] {
        return string.components(separatedBy: ";")
    }
    
    func prepareProductImage() -> PFFileObject? {
        if let imageData = productImageView.image!.pngData() {
            let file = PFFileObject(data: imageData)
            return file!
        }
        return nil
    }
    
    func validateFormInputs(name: String, blurb: String, priceString: String, tagString: String) -> Bool {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let number = formatter.number(from: priceString)
        
        if (name.isEmpty || blurb.isEmpty || priceString.isEmpty || tagString.isEmpty || number == nil) {
            return false
        }
        
        return true
    }
}
