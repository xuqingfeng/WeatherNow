
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    
    var locationMamager = CLLocationManager()
    var locationLongitude: Int!
    var locationLatitude: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.refreshActivityIndicator.hidden = true
        self.getWeatherInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshAction() {
        
        self.refreshButton.hidden = true
        self.refreshActivityIndicator.hidden = false
        self.refreshActivityIndicator.startAnimating()
        
        self.getWeatherInfo()
        
    }
    
    func getWeatherInfo() -> Void {
        
        self.locationMamager.delegate = self
        self.locationMamager.desiredAccuracy = kCLLocationAccuracyBest
        if self.iOS8Higher() {
            self.locationMamager.requestAlwaysAuthorization()
        }
        self.locationMamager.startUpdatingLocation()
        
        
        var apiURL = "http://api.openweathermap.org/data/2.5/weather?"
        //        var city = "Tokyo,JP"
        var url = NSURL(string: "\(apiURL)lat=\(self.locationLatitude)&lon=\(self.locationLongitude)")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            if error == nil {
                var jsonError: NSError?
                var weatherNSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
                
                if jsonError != nil {
                    println("json error")
                }
                
                println(weatherNSDictionary)
                
                var weatherModel = WeatherModel(weatherNSDictionary: weatherNSDictionary)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.iconView.image = weatherModel.weatherIcon!
                    self.locationLabel.text = weatherModel.location!
                    self.timeLabel.text = weatherModel.currentTime!
                    self.temperatureLabel.text = "\(weatherModel.temperature!)"
                    self.humidityLabel.text = "\(weatherModel.humidity!)%"
                    self.weatherLabel.text = weatherModel.description!
                    
                    // stop refresh
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshActivityIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
                
                
            }
        })
        task.resume()
    }
    
    
    
    func iOS8Higher() -> Bool {
        
        var sysVersion = UIDevice.currentDevice().systemVersion
        var sysVersionDou = (sysVersion as NSString).doubleValue
        
        if sysVersionDou >= 8 {
            return true
        }
        return false
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var location = locations[locations.count - 1] as CLLocation
        
        if location.horizontalAccuracy > 0 {
            self.locationLongitude = Int(location.coordinate.longitude)
            self.locationLatitude = Int(location.coordinate.latitude)
            self.locationMamager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }

}

