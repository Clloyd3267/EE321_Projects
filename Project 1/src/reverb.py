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
    
    # CDL=> Add validation for inputs

    # CDL=> Remove plotting later
    fig = plt.figure()
    reverbAudioData = np.empty(0)
    for echoNumber in range(numberOfEchos):
        delayedEchoAudioData = delay((audioData * (gain ** (echoNumber))), sampleRate, delayTimeSec * (echoNumber) )
        reverbAudioData.resize(delayedEchoAudioData.shape)
        reverbAudioData = reverbAudioData + delayedEchoAudioData
        
        # Plot overlay's
        ax = fig.add_subplot(numberOfEchos + 1, 1, echoNumber + 2)
        ax.set_xlim(0, 2)
        ax.set_ylim(-0.5, 0.5)
        ax.grid(True)
        xAxis = np.arange(len(delayedEchoAudioData)) / sampleRate
        ax.plot(xAxis, delayedEchoAudioData)

    # Plot final reverb'd audio
    ax = fig.add_subplot(numberOfEchos + 1, 1, 1)
    ax.set_xlim(0, 2)
    ax.set_ylim(-0.5, 0.5)
    ax.grid(True)
    xAxis = np.arange(len(reverbAudioData)) / sampleRate
    ax.plot(xAxis, reverbAudioData)
    fig.tight_layout()
    plt.show()

    return reverbAudioData


# Main code for this file
if __name__ == "__main__":
    # Simple test to add reverb to audio sample
    print("=> Audio reverb test: ")
    inFilePath = Path("../Audio Files/JUST_HEY.mp3")
    outFilePath = Path("../Audio Files/TEST_HEY_reverb.mp3")
    sampleRate, audioData = importMP3Audio(inFilePath, True)
    print("Audio Imported Successfully...")
    numberOfEchos 5
    delayTimeSec = 0.3
    gain = 0.5
    reverbedAudioData = reverb(audioData, numberOfEchos, sampleRate, delayTimeSec, gain)
    print("Audio Reverbed Successfully...")
    exportMP3Audio(outFilePath, reverbedAudioData, sampleRate, True)
    print("Audio Exported Successfully...")

