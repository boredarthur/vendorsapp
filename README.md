# vendorsapp
An iOS application, which reads the data from local .json (vendors.json) and display the information in a list.</br>
User can search for vendors, which are ordered by company name. As user scrolls down the list, app loads new vendors from json file.\n
By default, only 4 vendors and being displayed and with each further fetch request additional 4 are being appended to the list.

## Technologies used
- Swift
- SwiftUI
- Combine
- Redux architecture

## Third-party libraries used
- Kingfisher (for image download)
- SVGKit (for converting .svg icons into images)

## Possible areas for improvements
- Improve networking service to use remote API, which will support pagination (parameters like page=x&limit=x)
- Better handling of low data connection
- Create UI tests
- Create back-up networking service, which will use some another API

## Screenshots

<div style="display: flex;align-items: center;justify-content: center;">
  <img src="https://i.imgur.com/sa5BNqb.png"  width="30%" height="10%">
  <img src="https://i.imgur.com/WPfkR1W.png"  width="30%" height="10%">
  <img src="https://i.imgur.com/cMdrwLN.png"  width="30%" height="10%">
</div>
