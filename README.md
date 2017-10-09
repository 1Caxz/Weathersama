# Weathersama
Weathersama is library for access weather data on openweathermap.org.
You can find clone apple weather app in WeatersamaDemo project.

This is simple library with class model inside. You can make code short and faster. This library integrated with google geocode. So, its simple to find location and send that to get weather data.
<br><br>
<div style="text-align: center;">
<img align="center" width="250" src="https://github.com/icaksama/Weathersama/blob/master/ss1.jpeg">&nbsp;&nbsp;&nbsp;
<img align="center" width="250" src="https://github.com/icaksama/Weathersama/blob/master/ss2.jpeg">&nbsp;&nbsp;&nbsp;
<img align="center" width="250" src="https://github.com/icaksama/Weathersama/blob/master/ss3.jpeg">
<div>

<br><br>
How to Install project demo :
1. Download the project
2. Open WeathersamaDemo.xcworkspace
2. No need to change appId or googleKey
3. Library still on progress to upload in cocoapods repository. So, you need to change directory library on Podfile WeathersamaDemo "pod 'Weathersama', :path => '/go/to/library/directory/Weathersama'"
3. Change Bundle indentifier & Run

# Note :
Daily forecast feature in openweathermap.org has been transfered to paid version. So, I use sample daily forecast with this url :  http://samples.openweathermap.org/data/2.5/forecast/daily?id=524901&appid=b1b15e88fa797225412429c1c50c122a1.
Data for daily forecast should be same in different country.

![alt text](https://github.com/icaksama/Weathersama/blob/master/Screen%20Shot%202017-10-09%20at%209.36.32%20AM.png)
