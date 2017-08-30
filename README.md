# Google-Sheets-Mobile-Updater-iOS-

Works off of the example code presented here: https://developers.google.com/sheets/api/quickstart/ios?ver=swift

This app adds the following functionality:
- Seperate window for sign in. Moves to next ViewController at start on succesful login.
- Added ability to list all Google Sheets files a user owns. Which included using the Google Drive API rather than the Sheets API.
- Added ability to update a sheet cell by giving a location, and string in a UITextField.
- Google Sheets ID can be recieved from app now rather than looking at the URL separately.
- Works on iOS 11. 


INSTALL:
Follow directions in above link (https://developers.google.com/sheets/api/quickstart/ios?ver=swift)
But basically:
- Use my PODFILE, and run pod install in directory
- Open TestiOS.xcworkspace
- Turn on Sheets API
- Add url from GoogleService-Info.plist (Obsolete one is in correct place under URL in the info section of the project in xcode)
- Modify, Compile, and Run. 


