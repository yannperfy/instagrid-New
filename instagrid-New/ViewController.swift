//
//  ViewController.swift
//  instagrid-New
//
//  Created by Yann Perfy on 16/04/2022.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var bouttonPlusView: UIView!
    @IBOutlet weak var swipeToShareStack: UIStackView!
    @IBOutlet weak var formStackView: UIStackView!
    @IBOutlet var bouttonPlusImage: [UIButton]!
    @IBOutlet var formBttons: [UIButton]!
    @IBOutlet weak var bouttonForm1: UIButton!
    @IBOutlet weak var bouttonForm2: UIButton!
    @IBOutlet weak var bouttonForm3: UIButton!
    
    
    
    private var swipeGestureRecognizer : UISwipeGestureRecognizer?
    
    
    var indexButtons = Int()
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bouttonPlusView.layer.cornerRadius = 15
        bouttonForm1.layer.cornerRadius = 6
        bouttonForm2.layer.cornerRadius = 6
        bouttonForm3.layer.cornerRadius = 6
        
        
        imagePickerController.delegate = self
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(displayActivityController(_:)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupSwipeDirection), name:UIDevice.orientationDidChangeNotification,object: nil)
        
        guard let swipeGestureRecognizer = swipeGestureRecognizer else { return }
       bouttonPlusView.addGestureRecognizer(swipeGestureRecognizer)
    }

    //     Handle swipe direction whether up or left
    @objc func setupSwipeDirection() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGestureRecognizer?.direction = .left
        } else {
            swipeGestureRecognizer?.direction = .up
        }
    }
    

    @objc func displayActivityController(_ sender: UIActivityItemSource) {
        print("ActivityController opened")
        let imageView = imageConvert(bouttonPlusView)
        let activityController = UIActivityViewController(activityItems: [imageView as Any], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        self.shareView()
        
        //Completion handler
        activityController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                print("share completed")
                self.cancelShareView()
                return
            } else {
                print("cancel")
                self.cancelShareView()
            }
        }
    }
    
    // Method in order to convert UIview as UImage
    func imageConvert(_ view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    

    @IBAction func formBoutton(_ sender: UIButton) {
        formBttons.forEach { $0.isSelected = false }
        sender.isSelected = true
        switch sender.tag {
        case 0:
            bouttonPlusImage[0].isHidden = true
            bouttonPlusImage[3].isHidden = false
        case 1:
            bouttonPlusImage[0].isHidden = false
            bouttonPlusImage[3].isHidden = true
        case 2:
            bouttonPlusImage[0].isHidden = false
            bouttonPlusImage[3].isHidden = false
        default:
            break
        }
    }
    

    
    @IBAction func putPictures(_ sender: UIButton) {
        indexButtons = sender.tag
        showImagePickerController()
    }
    
    
    
    func shareView () {
        if UIDevice.current.orientation.isLandscape {
            let screenWidth = UIScreen.main.bounds.width
            let translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
            UIView.animate(withDuration: 0.5) {
                self.bouttonPlusView.transform = translationTransform
                self.swipeToShareStack.transform = translationTransform
            }
        } else {
            let screenHeight = UIScreen.main.bounds.height
            let translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
            UIView.animate(withDuration: 0.5) {
                self.swipeToShareStack.transform = translationTransform
                self.bouttonPlusView.transform = translationTransform
            }
        }
    }
    
    // Gridview & Swipe label reappear
    func cancelShareView() {
        let translationTransform = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.swipeToShareStack.transform = .identity
            self.bouttonPlusView.transform = translationTransform
        }
    }
}

