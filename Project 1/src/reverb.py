################################################################################
# Name        : reverb.py
# Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
# Class       : EE321 (Project 1)
# Due Date    : 2020-09-18
# Description : Functions to add reverb to an audio sample stored in a Numpy 
#               array.
################################################################################

# Imports
from common import *  # Only for testing!
import numpy as np

def reverb(audioData):
    """
    Function to add reverb to audio data stored in a Numpy array.

    Parameters:
        audioData    (Numpy array): Numpy array that represents audio data.

    Returns:
        (Numpy array): Numpy array that represents audio data with added reverb.
    """    
    
    # CDL=> Add validation for inputs

    # CDL=> Come back here later

    return audioData


# Main code for this file
if __name__ == "__main__":
    # Simple test to add reverb to audio sample
    print("=> Audio reverb test: ")
    inFilePath = Path("../Audio Files/HEY.mp3")
    outFilePath = Path("../Audio Files/TEST_HEY_reverb.mp3")
    sampleRate, audioData = importMP3Audio(inFilePath, True)
    print("Audio Imported Successfully...")
    reverbedAudioData = reverb(audioData)
    print("Audio Reverbed Successfully...")
    exportMP3Audio(outFilePath, reverbedAudioData, sampleRate, True)
    print("Audio Exported Successfully...")

