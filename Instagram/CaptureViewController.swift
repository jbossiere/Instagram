//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Julian Test on 3/2/17.
//  Copyright © 2017 Julian Bossiere. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var textBGView: UIView!
    @IBOutlet weak var postImageView: UIImageView!
    
    let vc = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.choosePhotoButton.layer.cornerRadius = 5
        self.takePhotoButton.layer.cornerRadius = 5
        
        self.postImageView.isHidden = true
        self.captionTextField.isHidden = true
        self.textBGView.isHidden = true
        self.shareButton.isEnabled = false

        self.vc.delegate = self
        self.vc.allowsEditing = true
        
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        print("going to TAKE photo!")
        vc.sourceType = UIImagePickerControllerSourceType.camera
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func choosePhoto(_ sender: Any) {
        print("going to CHOOSE photo!")
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
//        print(info)
        self.choosePhotoButton.isHidden = true
        self.takePhotoButton.isHidden = true
        self.captionTextField.isHidden = false
        self.postImageView.isHidden = false
        self.textBGView.isHidden = false
        self.shareButton.isEnabled = true
        self.postImageView.image = originalImage

        dismiss(animated: true, completion: nil)
    }

    @IBAction func postPhoto(_ sender: Any) {
        let imageToPost = resize(image: self.postImageView.image!, newSize: CGSize(width: 600, height: 600))
        let caption = self.captionTextField.text!
        Post.postUserImage(image: imageToPost, withCaption: caption) { (success: Bool, error: Error?) in
            if success {
                self.choosePhotoButton.isHidden = false
                self.takePhotoButton.isHidden = false
                self.captionTextField.isHidden = true
                self.postImageView.isHidden = true
                self.textBGView.isHidden = true
                self.shareButton.isEnabled = false
            } else {
                print("error: \(error?.localizedDescription)")
            }
        }
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
