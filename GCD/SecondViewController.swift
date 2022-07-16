//
//  SecondViewController.swift
//  GCD
//
//  Created by Федор Донсков on 16.07.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        
        // Выполняется когда я хочу получить значение image
        get {
            return imageView.image
        }
        
        // Выполняется при установке нового значения для свойства
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            
            // Возвращаюсь в главный поток, что бы продолжить работать с интерфейсом
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
