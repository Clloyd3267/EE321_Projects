################################################################################
# Name        : delay.py
# Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
# Class       : EE321 (Project 1)
# Due Date    : 2020-09-18
# Description : Functions to add delay to an audio sample stored in a Numpy 
#               array.
################################################################################

# Imports
from common import *  # Only for testing!
import numpy as np

def delay(audioData, sampleRate, delayTimeSec):
    """
    Function to add delay to audio data stored in a Numpy array.

    Parameters:
        audioData    (Numpy array): Numpy array that represents audio data.
        sampleRate   (int)        : The sample rate of the audio data.
        delayTimeSec (int)        : Delay time in seconds used for audio data.

    Returns:
        (Numpy array): Numpy array that represents audio data with added delay.
    """    

    # Compute number of zeros to prepend to numpy array
    numZeros = delayTimeSec * sampleRate    

    # Return delayed numpy array
    return np.concatenate((np.zeros(int(numZeros)), audioData))


# Main code for this file
if __name__ == "__main__":
    # Simple test to add delay to audio sample
    print("=> Audio delay for 1 second test: ")
    inFilePath = Path("../Audio Files/HEY.mp3")
    outFilePath = Path("../Audio Files/TEST_HEY_delayed_1_second.mp3")
    delayTimeSec = 1
    sampleRate, audioData = importMP3Audio(inFilePath)
    print("Audio Imported Successfully...")
    delayedAudioData = delay(audioData, sampleRate, delayTimeSec)
    print("Audio Delayed Successfully...")
    exportMP3Audio(outFilePath, delayedAudioData, sampleRate)
    print("Audio Exported Successfully...")
