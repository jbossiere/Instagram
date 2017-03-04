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
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var postImageView: UIImageView!
    
    let vc = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        choosePhotoButton.layer.cornerRadius = 5
        takePhotoButton.layer.cornerRadius = 5
        shareButton.layer.cornerRadius = 5
        
        postImageView.isHidden = true
        captionTextField.isHidden = true
        shareButton.isHidden = true

        vc.delegate = self
        vc.allowsEditing = true
        
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
        choosePhotoButton.isHidden = true
        takePhotoButton.isHidden = true
        captionTextField.isHidden = false
        postImageView.isHidden = false
        shareButton.isHidden = false
        postImageView.image = originalImage

        dismiss(animated: true, completion: nil)
    }

    @IBAction func sharePost(_ sender: Any) {
        Post.postUserImage(image: postImageView.image!, withCaption: captionTextField.text!) { (success: Bool, error: Error?) in
            if success {
                self.choosePhotoButton.isHidden = false
                self.takePhotoButton.isHidden = false
                self.captionTextField.isHidden = true
                self.postImageView.isHidden = true
               self.shareButton.isHidden = true
            } else {
                print("error: \(error?.localizedDescription)")
            }
        }

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
