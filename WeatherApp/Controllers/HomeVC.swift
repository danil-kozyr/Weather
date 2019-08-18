//
//  HomeVC.swift
//  WeatherApp
//
//  Created by Daniil KOZYR on 7/17/19.
//  Copyright © 2019 Daniil KOZYR. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    private var locationDownloader = LocationDownloader()
    private var weatherDownloader = WeatherDownloader()
    private var keyboardSize: CGFloat?
    
    @IBOutlet private weak var city: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var inputCity: UITextField! {
        didSet {
            inputCity.delegate = self
            inputCity.attributedPlaceholder = NSAttributedString(
                string: "Enter city here...",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
            )
        }
    }
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        downloadWeather(in: "Kyiv")
    }
    
    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.setGradientBackground(topColor: UIColor.Theme.darkBlue, bottomColor: UIColor.Theme.lightBlue)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        activityIndicator.isHidden = true
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateWeatherIcon(for weatherType: String?) {
        let imageName: String
        
        switch weatherType {
        case "clear-day":
            imageName = "day"
        case "clear-night":
            imageName = "night"
        case "rain":
            imageName = "rain"
        case "snow":
            imageName = "snow"
        case "wind":
            imageName = "wind"
        case "fog":
            imageName = "fog"
        case "cloudy", "partly-cloudy-day":
            imageName = "cloudy"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        default:
            imageName = "default"
        }
        
        icon.image = UIImage(named: imageName)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard keyboardSize == nil else { return }
        keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height
        
        if self.view.frame.origin.y == 0 {
            UIView.animate(withDuration: 1.0) {
                self.icon.alpha = 0
            }
            self.view.frame.origin.y -= keyboardSize!
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            UIView.animate(withDuration: 1.0) {
                self.icon.alpha = 1
            }
            self.view.frame.origin.y = 0
        }
    }
    
    private func setLoadingState(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE | MMMM d yyyy | h:mm"
        return formatter.string(from: date)
    }
    
    private func downloadWeather(in cityName: String) {
        date.text = formatDate(Date())
        setLoadingState(true)
        
        locationDownloader.requestLocation(city: cityName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let city):
                self.weatherDownloader.makeRequest(location: city) { [weak self] result in
                    guard let self = self else { return }
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let temperature):
                            self.city.text = city.city
                            self.temperature.text = "\(temperature.tmp)°C, \(temperature.summary)"
                            self.updateWeatherIcon(for: temperature.icon)
                        case .failure(let error):
                            self.city.text = error.localizedDescription
                            self.temperature.text = "Error"
                        }
                        self.setLoadingState(false)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleLocationError(error)
                    self.setLoadingState(false)
                }
            }
        }
    }
    
    private func handleLocationError(_ error: DownloaderError) {
        switch error {
        case .invalidCity:
            self.city.text = "Invalid City"
            self.temperature.text = "Error"
        case .noInternetConnection:
            self.temperature.text = "Error"
            self.city.text = "Check Internet Connection"
        case .noConnectionWithAPI:
            self.temperature.text = "Error"
            self.city.text = "Servers are busy. Try again!"
        }
    }
}

extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputCity.resignFirstResponder()
        
        if let cityText = inputCity.text, !cityText.isEmpty {
            downloadWeather(in: cityText)
        } else {
            city.text = "Enter any city!"
        }
        
        return true
    }
}


