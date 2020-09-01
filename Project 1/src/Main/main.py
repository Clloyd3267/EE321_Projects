################################################################################
# Name        : main.py
# Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
# Class       : EE321 (Project 1)
# Due Date    : 2020-09-18
# Description : CDL=> Here Later
################################################################################

# Imports
# TODO move import statements and functions to separate files
import urllib.request
import time
import pydub
import numpy as np

from pydub import AudioSegment
from pydub.playback import play

def read(f, normalized=False):
    """MP3 to numpy array"""
    a = pydub.AudioSegment.from_mp3(f)
    y = np.array(a.get_array_of_samples())
    if a.channels == 2:
        y = y.reshape((-1, 2))
    if normalized:
        return a.frame_rate, np.float32(y) / 2**15
    else:
        return a.frame_rate, y

def write(f, sr, x, normalized=False):
    """numpy array to MP3"""
    channels = 2 if (x.ndim == 2 and x.shape[1] == 2) else 1
    if normalized:  # normalized array - each item should be a float in [-1, 1)
        y = np.int16(x * 2 ** 15)
    else:
        y = np.int16(x)
    song = pydub.AudioSegment(y.tobytes(), frame_rate=sr, sample_width=2, channels=channels)
    song.export(f, format="mp3", bitrate="320k")

def delay(delayPeriod, sampleRate, audioData):
    zeros = delayPeriod * sampleRate    #compute number of zeros to prepend to numpy array

    #prepend zeros to numpy array to cause delay for x seconds
    for x in range(zeros):
        audioData = np.insert(audioData, 0, x, axis=0)

    return audioData    #return delayed numpy array

def main():

    #temporary section to demonstrate loading files
    #read file in to numpy array
    frameRate, audio = read("HEY.mp3") #KAB this currently works and creates a numpy get_array_of_samples
    #KAB would be nice to have a play function call from pydub here to play the original file
    # for x in audio:
    #     print(x)
    #create delayed array for sound file
    audio = delay(1, frameRate, audio)

    #create new sound file from numpy array
    write('HEY_Delay.mp3', frameRate, audio)

    """
    Main function to demo audio effects including:
    - Delay
    - Echo
    - Reverb

    Parameters: (None)
    Returns:    (None)
    """
    print("hello world!")

    time.sleep(5)

main()

#if __name__ == "__main__":
 #   main()
