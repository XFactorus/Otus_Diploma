# Dogs breed detector
Otus diploma project "Dogs breed detector" which allows to quickly detect dog's breed by photo and load more info about it from external API

## Project details

1. How it works?
- User takes a photo or load it from library, app analyzes it with trained CoreML model and shows the results. After user selects one of the found breed (it could be several if we are not sure) - more info about dog is loaded, like height, weight, temperament, etc.
2. How many breeds could be detected?
- Currently CoreML model is trained to detect up to 100 dog breeds. Detection results could be different depending on the dog breed and quality of the photo.
