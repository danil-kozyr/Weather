# Weather App

An elegant iOS weather application with real-time data, beautiful animations, and intuitive design, showcasing modern Swift development practices.

## 📖 About

Weather App is a native iOS application that provides accurate weather information for any city worldwide. Built with Swift and featuring a clean, gradient-based interface with smooth animations and responsive design.

## 🚀 Features

- **Real-time Weather Data**: Current conditions and temperature for any location
- **Beautiful UI**: Custom gradient backgrounds with smooth animations
- **Weather Visualization**: Dynamic weather icons representing current conditions
- **Smart Search**: Natural language city search with autocomplete
- **Responsive Design**: Adaptive keyboard handling and smooth transitions
- **Error Handling**: Comprehensive network and API error management
- **Date Display**: Real-time date and time information

## 🔧 Build Instructions

### Prerequisites

- iOS 15.0+
- Xcode 13.0+
- Swift 5.0+
- CocoaPods dependency manager

### Setup

```bash
# Clone the repository
git clone https://github.com/danil-kozyr/Weather.git
cd Weather

# Install dependencies
pod install

# Open workspace in Xcode
open WeatherApp.xcworkspace
```

### API Configuration

```swift
// WeatherDownloader.swift
private let darkSkyToken = "YOUR_DARKSKY_API_KEY_HERE"

// LocationDownloader.swift
private let recastAIToken = "YOUR_RECAST_AI_API_KEY_HERE"
```

## 📝 Usage

### Access the Application

Build and run the project in Xcode or iOS Simulator

### Core Features

- **City Search**: Enter any city name in the search field
- **Weather Display**: View current temperature and conditions
- **Visual Feedback**: Weather-appropriate icons and animations
- **Keyboard Navigation**: Smooth keyboard handling with UI adjustments

### Weather Search Process

1. Launch the application
2. Enter city name in search field
3. Press return or search button
4. View real-time weather data
5. Enjoy smooth animations and transitions

## 🎬 Demonstration

<p align="center">
<img src="https://github.com/danilkozyr/iOS-Portfolio/raw/master/gifs/weather.gif" height=600>
</p>

## 🔍 Implementation Details

### Architecture

- **Pattern**: Model-View-Controller (MVC)
- **Language**: Swift 5.0
- **Framework**: UIKit with programmatic constraints
- **Networking**: Asynchronous API calls with completion handlers
- **UI**: Custom gradient backgrounds and smooth animations

### Key Components

- **HomeVC**: Main view controller handling user interactions
- **WeatherDownloader**: Service for fetching weather data from DarkSky API
- **LocationDownloader**: Geocoding service using RecastAI for city parsing
- **Extensions**: Custom UI utilities and temperature conversion helpers
- **Models**: Data structures for City, Temperature, and weather information

## 🔗 Dependencies

### Third-party Libraries

- **[DarkSkyKit](https://darksky.net/dev/docs)**: Weather API client for accurate weather data
- **[RecastAI](https://cai.tools.sap/)**: Natural language processing for location parsing

### System Frameworks

- **UIKit**: User interface framework
- **Foundation**: Core system functionality
- **CoreLocation**: Location services integration

---

_Native iOS application demonstrating modern Swift development, API integration, custom UI design, and professional code architecture._
