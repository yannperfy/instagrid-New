//
//  Extension.swift
//  instagrid-New
//
//  Created by Yann Perfy on 16/04/2022.
//

import Foundation
import UIKit


extension ViewController: UIImagePickerControllerDelegate {
    
// Methods to pick photos from library
    
    func showImagePickerController() {
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            bouttonPlusImage[indexButtons].setImage(image, for: .normal)
            bouttonPlusImage[indexButtons].imageView?.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
