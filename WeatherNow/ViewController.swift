
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var apiURL = "http://api.openweathermap.org/data/2.5/weather?q="
        var city = "Tokyo,JP"
        var url = NSURL(string: "\(apiURL)\(city)")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            if error == nil {
                var weatherNSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                
                println(weatherNSDictionary)
                
                var weatherModel = WeatherModel(weatherNSDictionary: weatherNSDictionary)
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.iconView.image = weatherModel.weatherIcon!
                    self.locationLabel.text = weatherModel.location!
                    self.timeLabel.text = weatherModel.currentTime!
                    self.temperatureLabel.text = "\(weatherModel.temperature!)"
                    self.humidityLabel.text = "\(weatherModel.humidity!)%"
                    self.weatherLabel.text = weatherModel.description!
                    
                })
                
                
            }
        })
        task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

