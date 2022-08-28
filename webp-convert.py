from pathlib import Path
from PIL import Image
import sys

# converting images found in a given directory to webp
# this scripts takes two command line arguments
# the first is the directory to search for images
# the second is the extension of the images to convert

imageDir = sys.argv[1]
imageExt = sys.argv[2]

def convert_to_webp(source): 
    destination = source.with_suffix(".webp")
    print("Converting" + source.name + "to" + destination.name)
    image = Image.open(source)  # Open image
    image.save(destination, format="webp")  # Convert image to webp
    return destination

def main():
    paths = Path(imageDir).glob("*." + imageExt)
    for path in paths: 
        webp_path = convert_to_webp(path)
        print(webp_path)

main()