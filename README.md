# Dogs breed detector
Otus diploma project "Dogs breed detector" which allows to quickly detect dog's breed by photo and load more info about it from external API

## Project details

1. How it works?
- User takes a photo or load it from library, app analyzes it with trained CoreML model and shows the results. 
- After user selects one of the found breed (it could be several if we are not sure) - more info about dog is loaded, like height, weight, temperament, etc.
2. How many breeds could be detected?
- Currently CoreML model is trained to detect up to 100 dog breeds. Detection results could be different depending on the dog breed and quality of the photo.
3. Which network features are used?
- After app detects dog breed, user can get more info about it by tapping on the detection result.
We get it from the https://thedogapi.com/ service. 
Once info received once, info will be stored locally on your device and will not be loaded during next requests.

## Install
1. Clone the project and launch the DogsBreedDetector.xcodeproj project file
2. Add Keys.plist file to the project, with the *"DogApiKey"* string key set to your API key from https://thedogapi.com/
3.  Build and run the project. All required dependices will be connected automatically.

### References
- **Stanford Dogs Dataset**. Available at: http://vision.stanford.edu/aditya86/ImageNetDogs/
- **Tsinghua Dogs Datasett**. Available at: https://cg.cs.tsinghua.edu.cn/ThuDogs/
- **The Dog API**. Available at: https://thedogapi.com/
