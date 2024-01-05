//
//  ViewController.swift
//  SeSacEmotion
//
//  Created by Greed on 1/2/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var emotionButton: [UIButton]!
    
    @IBOutlet var emotionLabel: [UILabel]!
    
    //튜플을 활용해서 데이터 변수를 하나로 설정
    var emotionList: [(imageName: String,labelValue: String,Count: Int)] = [("slime1", "행복해", 0), ("slime2", "사랑해", 0),("slime3", "좋아해", 0),("slime4", "당황해", 0),("slime5", "속상해", 0),("slime6", "우울해", 0),("slime7", "심심해", 0),("slime8", "황당해", 0),("slime9", "미안해", 0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        initialRandomCount()
        setLabel()
        setImages()
    }
    
    @IBAction func slimeButtonClicked(_ sender: UIButton) {
        
        emotionList[sender.tag].Count += 1
        UserDefaults.standard.set(emotionList[sender.tag].Count, forKey: "\(sender.tag)")
        setImages()
    }
    
    func setImages() {
        
        for index in 0...emotionButton.count - 1 {
            designSlimeButton(emotionButton[index],
                              label: emotionLabel[index],
                              tag: index,
                              imageName: emotionList[index].imageName,
                              text: "\(emotionList[index].labelValue)" + " \(emotionList[index].Count)")
        }
        
    }
    
    func designSlimeButton(_ button: UIButton, label: UILabel, tag: Int, imageName: String, text: String) {
        
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tag = tag
        label.font = .systemFont(ofSize: 15)
        label.text = text
        
    }
    
    func setLabel() {
        for i in 0...emotionList.count - 1 {
            emotionList[i].Count = UserDefaults.standard.integer(forKey: "\(i)")
        }
    }
    
    func randomCount() {
        
        for i in 0...emotionList.count - 1 {
            let randomNumber = Int.random(in: 0...100)
            UserDefaults.standard.set(randomNumber, forKey: "\(i)")
            emotionList[i].Count = UserDefaults.standard.integer(forKey: "\(i)")
        }
    }
    
    func initialRandomCount() {
        if !UserDefaults.standard.bool(forKey: "isNotInitial") {
            UserDefaults.standard.set(true, forKey: "isNotInitial")
            for i in 0...emotionList.count - 1 {
                let randomNumber = Int.random(in: 0...100)
                UserDefaults.standard.set(randomNumber, forKey: "\(i)")
                emotionList[i].Count = UserDefaults.standard.integer(forKey: "\(i)")
            }
        }
    }
    
    func setNavigationBar() {
        navigationItem.title = "감정 다이어리"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func listButtonClicked() {
        randomCount()
        setImages()
    }
    
}
