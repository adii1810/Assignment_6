//
//  ViewController.swift
//  Assignment_6
//
//  Created by DCS on 08/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let tabbar: UITabBar = {
        let tabar = UITabBar()
        let item1 = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let item2 = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        tabar.items = [item1,item2]
        return tabar
    }()
    private let lblName:UILabel = {
        let lbl = UILabel()
        lbl.text = "Name :"
        return lbl
    }()
    private let txtName:UITextField = {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        return txt
    }()
    
    private let lblAdd:UILabel = {
        let lbl = UILabel()
        lbl.text = "Address:"
        return lbl
    }()
    private let txtAdd:UITextView = {
        let txt = UITextView()
        return txt
    }()
    
    private let lblDob:UILabel = {
        let lbl = UILabel()
        lbl.text = "City :"
        return lbl
    }()
//    private let date:UIDatePicker = {
//
//    }()
    
    private let cityPicker = UIPickerView ()
    
    private let data = ["Surat","Bharuch","Baroda","Ankleshwar"]
    
    
    private let lblPic:UILabel = {
        let lbl = UILabel()
        lbl.text = "D.O.B :"
        return lbl
    }()
    
    private let date = UIDatePicker()
    
    private let txtDate:UITextField = {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        return txt
    }()
    
    private let lblAge:UILabel = {
        let lbl = UILabel()
        lbl.text = "Year Of Experience :"
        return lbl
    }()
    
    private let step:UIStepper = {
        
        let stp = UIStepper()
        stp.minimumValue  = 0
        stp.maximumValue = 10
        stp.addTarget(self, action: #selector(getval), for: .valueChanged)
        
        return stp
        
    }()
    
    private let lblyear:UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        return lbl
    }()
    
    
    private let lblGender:UILabel = {
        let lbl = UILabel()
        lbl.text = "Gender :"
        return lbl
    }()
    
    private let Switch:UISwitch = {
            let swt = UISwitch()
        swt.addTarget(self, action: #selector(gender), for: .valueChanged)
        return swt
    }()
    
    private let lblgen:UILabel = {
        let lbl = UILabel()
        lbl.text = "Male"
        return lbl
    }()
    
    private let lblSalary:UILabel = {
        let lbl = UILabel()
        lbl.text = "Expected Salary :"
        return lbl
    }()
    
    private let lblslide:UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        return lbl
    }()
    
    private let slider:UISlider = {
        
        let stp = UISlider()
        stp.minimumValue  = 1000
        stp.maximumValue = 1000000
        stp.addTarget(self, action: #selector(sliderr), for: .valueChanged)
        
        return stp
        
    }()
    
    private let submit:UIButton = {
        let btn = UIButton()
        btn.setTitle("Submit", for: .normal)
        btn.backgroundColor = .green
        btn.addTarget(self, action: #selector(done), for: .touchUpInside)
        return btn
    }()
    
    let progress = Progress(totalUnitCount: 10)
    
    private let progresss = UIProgressView()
    
    private let spinner = UIActivityIndicatorView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tabbar)
         view.addSubview(lblName)
         view.addSubview(lblAdd)
         view.addSubview(lblDob)
         view.addSubview(lblPic)
         view.addSubview(lblAge)
         view.addSubview(lblGender)
         view.addSubview(lblSalary)
        
        view.addSubview(txtName)
        view.addSubview(step)
        view.addSubview(lblyear)
        view.addSubview(Switch)
        view.addSubview(lblgen)
        view.addSubview(slider)
        view.addSubview(lblslide)
        view.addSubview(submit)
        view.addSubview(progresss)
        
        view.addSubview(txtDate)
        createDatePicker()
        
        self.txtAdd.layer.borderWidth = 1
        self.txtAdd.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(txtAdd)
        
        
        
        view.addSubview(cityPicker)
        tabbar.delegate = self
        cityPicker.delegate = self
        cityPicker.dataSource = self
        // Do any additional setup after loading the view.
       
    }
    
    func createDatePicker(){
        
        date.datePickerMode = .date
        txtDate.inputView = date
        txtDate.inputAccessoryView = createToolbar()
    }
    
    @objc func donePressed(){
        
        let formate = DateFormatter()
        formate.dateStyle = .medium
        formate.timeStyle = .none
        
        self.txtDate.text = formate.string(from: date.date)
        self.view.endEditing(true)
    }
    
    @objc func gender(){
        if (Switch.isOn){
            lblgen.text = "Female"
        }
        else{
            lblgen.text = "Male"
        }
        
    }
    
    func createToolbar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        return toolbar
        
        
    }
    
    @objc func getval(){
        lblyear.text = "\(Int(step.value))"
    }
    
    @objc func sliderr(){
        lblslide.text = "\(Int(slider.value))"
    }
    
    @objc func done(){
        
      
        
        
        view.addSubview(spinner)
        self.spinner.color = .black
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (timer) in
            guard self.progress.isFinished == false else{
                timer.invalidate()
                print("Finished")
                
                self.spinner.stopAnimating()
                self.spinner.color = .white
                return
            }
            //self.spinner.isHidden = false
            self.spinner.startAnimating()
            self.progress.completedUnitCount += 1
            
            let progressFloat = Float(self.progress.fractionCompleted)
            self.progresss.setProgress(progressFloat, animated: true)
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let heigh:CGFloat = view.safeAreaInsets.top + 49.0
        tabbar.frame = CGRect(x: 0, y: view.frame.size.height - heigh
            , width: view.frame.size.width, height: heigh)
        
        lblName.frame = CGRect(x: 20, y: 50, width: 150, height: 20)
        txtName.frame = CGRect(x: 170, y: 50, width: 170, height: 30)
        
        lblAdd.frame = CGRect(x: 20, y: 100, width: 150, height: 20)
        txtAdd.frame = CGRect(x: 170, y: 100, width: 170, height: 50)

        lblDob.frame = CGRect(x: 20, y: 160, width: 150, height: 20)
        cityPicker.frame = CGRect(x: 170, y: 160, width: 170, height: 35)
        
        lblPic.frame = CGRect(x: 20, y: 210, width: 150, height: 20)
        txtDate.frame = CGRect(x: 170, y: 210, width: 170, height: 30)
        
        lblAge.frame = CGRect(x: 20, y: 260, width: 150, height: 20)
        step.frame = CGRect(x: 170, y: 260, width: 100, height: 30)
        lblyear.frame = CGRect(x: 300, y: 260, width: 20, height: 20)
        
        lblGender.frame = CGRect(x: 20, y: 310, width: 150, height: 20)
        Switch.frame  = CGRect(x: 170, y: 310, width: 50, height: 50)
        lblgen.frame = CGRect(x: 250, y: 310, width: 70, height: 20)
        
        lblSalary.frame = CGRect(x: 20, y: 360, width: 150, height: 20)
        slider.frame = CGRect(x: 170, y: 360, width: 70, height: 30)
        lblslide.frame = CGRect(x: 250, y: 360, width: 70, height: 30)
        
        submit.frame = CGRect(x: 20, y: 500, width: 100, height: 40)
        
        progresss.frame = CGRect(x: 0, y: view.frame.size.height - heigh - 20, width: view.frame.size.width, height: 10)
        spinner.frame = CGRect(x: 170, y: 400, width: 50, height: 50)
    
    }
}


    
   

extension ViewController:UITabBarDelegate{
    private func tabbar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.tag)
    }
}




extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
       var lbl = UILabel()
        
        if let v = view as? UILabel{
            lbl = v
        }
        
        lbl.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lbl.text = data[row]
        lbl.textAlignment = .center
        return lbl
        
        
    }
}


