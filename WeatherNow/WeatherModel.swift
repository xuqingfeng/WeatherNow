
import Foundation
import UIKit

class WeatherModel {
    
    var location: String?
    var currentTime: String?
    var temperature: Int?
    var weatherIcon: UIImage?
    var humidity: Int?
    var description: String?

    init(weatherNSDictionary: NSDictionary){
        
        // location
        self.location = weatherNSDictionary["name"] as? String
        
        // temperature
        var main = weatherNSDictionary["main"] as NSDictionary
        var mainTemp = main["temp"] as Double
        var tempC:Double = mainTemp - 273.15
        self.temperature = Int(tempC)
        // weatherIcon
        var weather = weatherNSDictionary["weather"] as NSArray
        var weatherNSDictionary = weather[0] as NSDictionary
        var weatherMain = weatherNSDictionary["main"] as String
        self.weatherIcon = iconFormat(weatherMain)
        
        // humidity
        self.humidity = main["humidity"] as? Int
        
        // description
        self.description = weatherNSDictionary["main"] as? String
        
        // currentTime
//        var unixTime = weatherNSDictionary["dt"] as Int
        var unixTime = 1418709600
//        var unixTimeInInt = unixTime.toInt()
        self.currentTime = timeFormat(unixTime)
    }
    
    func timeFormat(unixTime: Int) -> String {
        
        var timeInSeconds = NSTimeInterval(unixTime)
        var weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func iconFormat(weatherMain: String) -> UIImage {
        
        var iconName: String
        
        switch weatherMain {
            case "Thunderstorm":
                iconName = "thunderstorm"
            case "Drizzle":
                iconName = "rainy"
            case "Rain":
                iconName = "rainy"
            case "Snow":
                iconName = "snowy"
            case "Atmosphere":
                iconName = "windy"
            case "Clouds":
                iconName = "cloudy"
            case "Extreme":
                iconName = "thunderstorm"
            case "Additional":
                iconName = "windy"
            default:
                iconName = "sun-cloudy"
        }
        
        return UIImage(named: iconName)!
    }

    
    
    
}
