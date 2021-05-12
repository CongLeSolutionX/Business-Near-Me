# Business-Near-Me
This Swift app follow MVVM architectural pattern, use Yelp API 3.0, MapKit, no Storyboard, and more.

Please check this link for my demo video on how to run the app: https://drive.google.com/file/d/1RhPopV20Nj_UZRHc895QfZ4cEPChiJ1t/view?usp=sharing

Step to run this app:
1. Clone this repo
2. Open this project in XCode
3. Run the app.
4. If your run this app on simulator, we need to select a the location for the simulator: On XCode, select Debug->Simulate Location -> Pick any locations in USA.
5. On the Search Store Near Me scene, the app will as for current location. Please select `Allow While Using App`.
6. If you type a search term in the search bar, you will see a 25 stores near your location (I set this limit to avoid hitting allowed number of requests).
7. Click on  the Map View scene, you should see the current user's location and businesses around at location on the map view .

Note: If you receive status code 429 from Yelp API, you are sending too much requests. Please try again the next day.
