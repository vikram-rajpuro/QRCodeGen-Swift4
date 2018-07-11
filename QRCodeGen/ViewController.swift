//
//  ViewController.swift
//  QRCodeGen
//
//  Created by Vikram Sinha on 10/07/18.
//  Copyright © 2018 Vikram Sinha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtFieldContent: UITextField!
    @IBOutlet weak var btnGenrate: UIButton!
    @IBOutlet weak var imgVcQRCode: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    var qrcodeImage: CIImage!
    
    @IBAction func btnGenratePressed(_ sender: Any) {
        if qrcodeImage == nil{
            if txtFieldContent.text == ""{
                return
            }
            let data  = txtFieldContent.text?.data(using: String.Encoding.isoLatin1)
            let filter = CIFilter.init(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            qrcodeImage = filter?.outputImage

            displayQRCodeImag()
            txtFieldContent.resignFirstResponder()
            
            btnGenrate.setTitle("Clear", for: UIControlState.normal)
            txtFieldContent.isEnabled = !txtFieldContent.isEnabled
            slider.isHidden = !slider.isHidden
        }
        else{
            imgVcQRCode.image = nil
            qrcodeImage = nil
            btnGenrate.setTitle("Genrate", for: UIControlState.normal)
        }
    }
    
    func displayQRCodeImag(){
        let scaleX = imgVcQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgVcQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform.init(scaleX: scaleX, y: scaleY))
        imgVcQRCode.image = UIImage.init(ciImage: transformedImage)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        imgVcQRCode.transform = CGAffineTransform.init(scaleX: CGFloat(slider.value), y: CGFloat(slider.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

