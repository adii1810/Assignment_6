//
//  newView.swift
//  Assignment_6
//
//  Created by DCS on 08/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class newView: UIViewController {

    private let imageview = UIImageView()
    
    private let lblName:UILabel = {
        let lbl = UILabel()
        lbl.text = "Upload Image :"
        return lbl
    }()
    
    private let imagepicker: UIImagePickerController = {
        let imgpicker = UIImagePickerController()
        
        imgpicker.allowsEditing = false
        imgpicker.mediaTypes = ["public.image"]
        imgpicker.sourceType = .photoLibrary
        
        
        return imgpicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lblName)
        
        imagepicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedimg = info[imagepicker.info[]] as? UIImage{
            imageview.contentMode = .scaleAspectFit
            imageview.image = pickedimg
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
        lblName.frame = CGRect(x: 20, y: 50, width: 150, height: 20)
}
 
}
extension newView: UIImagePickerControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else{
            return self.imagepicker(picker, didSelect: nil)
        }
        self.imagepicker(picker,didSelect: image)
    }
}

