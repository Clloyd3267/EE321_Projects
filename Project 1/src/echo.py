################################################################################
# Name        : echo.py
# Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
# Class       : EE321 (Project 1)
# Due Date    : 2020-09-18
# Description : Functions to add echo to an audio sample stored in a Numpy 
#               array.
################################################################################

# Imports
from common import * # Only for testing!
import numpy as np

def echo(audioData, numberOfEchos, gain = 0.5):
    """
    Function to add echo(s) to audio data stored in a Numpy array.

    Parameters:
        audioData     (Numpy array): Numpy array that represents audio data.
        numberOfEchos (int)        : Number of echoes to add to audio.
        gain (float)      : Gain to multiply signal by for each echo.
                                     Must be between 0.0 and 1.0!

    Returns:
        (Numpy array): Numpy array that represents audio data with added echoes.
    """

    # CDL=> Add validation for inputs

    # CDL=> Perhaps clean up logic to simplify
    outAudio = audioDataoutAudio = audioData.copy()
    for echoNumber in range(numberOfEchos):
        outAudio = np.append(outAudio, (audioData * (gain ** (echoNumber+1))))
    return outAudio


# Main code for this file
if __name__ == "__main__":
    # Simple test to add echoes to audio sample
    print("=> Audio 2 echo's test: ")
    inFilePath = Path("../Audio Files/JUST_HEY.mp3")
    outFilePath = Path("../Audio Files/TEST_HEY_2_echos.mp3")
    numEchos = 2
    gainChange = 0.7
    sampleRate, audioData = importMP3Audio(inFilePath, True)
    print("Audio Imported Successfully...")
    echoAudioData = echo(audioData, numEchos, gainChange)
    print("Audio Echoed Successfully...")
    exportMP3Audio(outFilePath, echoAudioData, sampleRate, True)
    print("Audio Exported Successfully...")