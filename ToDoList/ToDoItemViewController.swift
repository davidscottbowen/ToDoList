//
//  ToDoItemViewController.swift
//  ToDoList
//
//  Created by David  Bowen on 10/24/16.
//  Copyright © 2016 David  Bowen. All rights reserved.
//

import UIKit
import  UserNotifications
import UserNotificationsUI

class ToDoItemViewController: UIViewController, UNUserNotificationCenterDelegate {
    static let shared = ToDoItemViewController()
    
    @IBOutlet weak var toDoTitle: UITextField!
    @IBOutlet weak var toDoDetail: UITextView!
    @IBOutlet weak var toDoDate: UILabel!
    @IBOutlet weak var datePickerValue: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var complete: UISwitch!
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    var toDo = ToDo()
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        toDoDate.text = toDo.dateString
        complete.isOn = toDo.complete
        toDoTitle.text = toDo.title
        toDoDetail.text = toDo.text
        imageView.image = toDo.image
        self.category.delegate = self
        self.category.dataSource = self
    }
    
    @IBAction func datePicker(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let strDate = dateFormatter.string(from: datePickerValue.date)
        toDoDate.text = strDate
    }
    
    func addGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func viewImage() {
        if let image = imageView.image {
            selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
        }
    }
    
    //func to choose camera or photo library
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func camera(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Picture", message: "Choose a picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in self.showPicker(.camera) }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in self.showPicker(.photoLibrary) }))
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // saves the fields data
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDo.title = toDoTitle.text!
        toDo.text = toDoDetail.text!
        toDo.date = datePickerValue.date
        toDo.category = category.selectedRow(inComponent: 0)
        toDo.image = imageView.image
        toDo.alert = toDoTitle.text!
        let notificationDate = toDo.date.timeIntervalSinceNow
        let notification = UNMutableNotificationContent()
        notification.title = toDo.title
        notification.subtitle = "DUE NOW"
        notification.categoryIdentifier = "alarm"
        notification.sound = UNNotificationSound.default()
        notification.body = "This ToDo has came due"
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: notificationDate, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: trigger)
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request)
        if complete.isOn {
            toDo.complete = true
        }
    }
}

extension ToDoItemViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil) //close the image picker when the user clicks cancel
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil) //still want to close the picker even when picking an image
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage { //if we actually get an image back, do this
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            //resizing our image and redrawing it within our image context, which is sized to maxSize for width and newHeight as height
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: maxSize, height: newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext() //setting our newly sized image to a constant called resizedImage
            UIGraphicsEndImageContext()
            
            imageView.image = resizedImage
            if gestureRecognizer != nil {
                imageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
    }
}

extension ToDoItemViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CategoryStore.shared.getCategoryTotal()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CategoryStore.shared.getCategory(row: row)
    }
}



