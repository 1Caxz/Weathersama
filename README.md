# Weathersama (Build on Swift 4, xCode 9.0)
Weathersama is library for access weather data on openweathermap.org.
You can find clone apple weather app in WeatersamaDemo project.

This is simple library with class model inside. You can make code short and faster. This library integrated with google geocode. So, its simple to find location and send that to get weather data.
<br><br>
<p align="center">
<img width="250" src="https://github.com/icaksama/Weathersama/blob/master/ss1.jpeg">&nbsp;&nbsp;&nbsp;
<img width="250" src="https://github.com/icaksama/Weathersama/blob/master/ss2.jpeg">&nbsp;&nbsp;&nbsp;
<img width="250" src="https://github.com/icaksama/Weathersama/blob/master/ss3.jpeg">
</p>
<br>

How to Install project demo :
1. Download the project
2. Open WeathersamaDemo.xcworkspace
2. No need to change appId or googleKey
3. Library still on progress to upload in cocoapods repository. So, you need to change directory library on Podfile WeathersamaDemo "pod 'Weathersama', :path => '/go/to/library/directory/Weathersama'"
3. Change Bundle indentifier & Run

# Note :
Daily forecast feature in openweathermap.org has been transfered to paid version. So, I use sample daily forecast with this url & data for daily forecast should be same in different country. http://samples.openweathermap.org/data/2.5/forecast/daily?id=524901&appid=b1b15e88fa797225412429c1c50c122a1.

And also data from openweathermap.org in some countries only for big city. For example, if you looking for weather on your location with latitude & longitude, sometimes the response will be data for big city or city near your location. It's not too accurate.

![alt text](https://github.com/icaksama/Weathersama/blob/master/Screen%20Shot%202017-10-09%20at%209.36.32%20AM.png)
