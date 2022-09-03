from pathlib import Path
from PIL import Image
import argparse
import sys
import os

# initialize the argument parser
parser = argparse.ArgumentParser()
parser.add_argument("-d", "--dir", help="Directory to convert images in", dest="imageDir")
parser.add_argument("-e", "--ext", help="Image extension to convert", dest="imageExt")
args = parser.parse_args()

# converting images found in a given directory to webp
# this scripts takes two command line arguments
# the first is the directory to search for images
# the second is the extension of the images to convert

def convert_to_webp(source): 
    destination = source.with_suffix(".webp")
    print("Converting " + source.name + " to " + destination.name + "\n")
    image = Image.open(source)  # Open image
    image.save(destination, format="webp")  # Convert image to webp
    return destination

def main():
    paths = Path(args.imageDir).glob("*." + args.imageExt)
    for path in paths: 
        if path.is_file():
            convert_to_webp(path)
    
    if( len(list(Path(args.imageDir).glob("*." + args.imageExt))) == 0 ):
        print("No " + args.imageExt + " files found in " + args.imageDir)
        os.system('echo "No ' + args.imageExt + ' files found in directory ' + args.imageDir + '" | terminal-notifier -title "Webp converter" -message "No ' + args.imageExt + ' files found in directory ' + args.imageDir + '"')
    else: 
        print("All " + args.imageExt + " files in directory " + args.imageDir + " converted to webp")
        os.system('echo ".' + args.imageExt + ' files in directory ' + args.imageDir + ' Converted" | terminal-notifier -title "Webp Converter" -message "' + args.imageExt + ' files in directory ' + args.imageDir + ' converted"')



main()