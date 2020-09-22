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
from delay import *
from echo import *
import numpy as np

def reverb(audioData, numberOfEchos, sampleRate, delayTimeSec, gain):
    """
    Function to add reverb to audio data stored in a Numpy array.

    Parameters:
        audioData     (Numpy array): Numpy array that represents audio data.
        sampleRate    (int)        : The sample rate of the audio data.
        delayTimeSec  (int)        : Delay time in seconds used for audio data.
        numberOfEchos (int)        : Number of echoes to add to audio.
        gain          (float)      : Gain to multiply signal by for each echo.
                                     Must be between 0.0 and 1.0!

    Returns:
        (Numpy array): Numpy array that represents audio data with added reverb.
    """    

    reverbAudioData = np.empty(0)
    for echoNumber in range(numberOfEchos):
        delayedEchoAudioData = delay((audioData * (gain ** (echoNumber))), 
                                     sampleRate, delayTimeSec * echoNumber)
        reverbAudioData.resize(delayedEchoAudioData.shape)
        reverbAudioData = reverbAudioData + delayedEchoAudioData

    return reverbAudioData


# Main code for this file
if __name__ == "__main__":
    # Simple test to add reverb to audio sample
    print("=> Audio reverb test: ")
    inFilePath = Path("../Audio Files/HEY.mp3")
    outFilePath = Path("../Audio Files/TEST_HEY_reverb.mp3")
    sampleRate, audioData = importMP3Audio(inFilePath)
    print("Audio Imported Successfully...")
    numberOfEchos = 5
    delayTimeSec = 0.3
    gain = 0.5
    reverbedAudioData = reverb(audioData, numberOfEchos, sampleRate, delayTimeSec, gain)
    print("Audio Reverbed Successfully...")
    exportMP3Audio(outFilePath, reverbedAudioData, sampleRate)
    print("Audio Exported Successfully...")

