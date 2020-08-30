//
//  ViewController.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 15.08.20.
//

import UIKit


class ViewController: UIViewController{
    
    
    @IBOutlet weak var mainMetalView: MyMetalView!
    @IBOutlet weak var swWireFrame: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swWireFrame.isOn = false
        
    }
    
    @IBAction func swWireFrameToggle(_ sender: Any) {
        mainMetalView.toggleWireFrame(wireFrameOn: swWireFrame.isOn)
        
    }
}

