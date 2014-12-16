
import Foundation

// get weather info from api

class APIModel {
    
    var apiURL = "http://api.openweathermap.org/data/2.5/weather?q="
    var weatherInfo: NSDictionary?
    
    init() {
        
    }
    
//    func getWeatherInfo(city: String) {
//    
//        
//        var url = NSURL(string: "\(self.apiURL)\(city)")
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
//            
//            if error == nil {
//                self.weatherInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//                
//            }
//        })
//        task.resume()
//    
//
//    }
    
    
}