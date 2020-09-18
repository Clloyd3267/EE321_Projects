################################################################################
# Name        : common.py
# Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
# Class       : EE321 (Project 1)
# Due Date    : 2020-09-18
# Description : Common functionality like import/export that can be shared for 
#               this project.
################################################################################

# Imports
import pydub 
import numpy as np
from pathlib import Path

def importMP3Audio(audioFileName):
    """
    Function to import audio from an MP3 file and convert it to a Numpy array.

    Description: Imports MP3 data using FFMPEG and Pydub to create an 
                 AudioSegment object which gets converted to a Numpy array. 
                 This array will be normalized from (-1 and +1).

    Parameters:
        audioFileName (string): The input MP3 audio file name.

    Returns:
        (int)        : The sample rate of the audio.
        (Numpy Array): The normalized audio data.
    """

    audioSegmentStereo = pydub.AudioSegment.from_mp3(audioFileName)
    audioNpArray = np.array(audioSegmentStereo.get_array_of_samples())
    
    # Reformat to floats between (-1 and +1)
    return audioSegmentStereo.frame_rate, np.float32(audioNpArray) / 2**15

def exportMP3Audio(audioFileName, audioNpArray, sampleRate):
    """
    Function to export audio from a Numpy array and convert it to a MP3 file.
    
    Description: 
        Exports MP3 data using FFMPEG and Pydub from an 
        AudioSegment object which gets converted from a Numpy array. 
        This array is normalized from (-1 and +1).

    Parameters:
        audioFileName (string)     : The output MP3 audio file name.
        audioNpArray  (Numpy Array): The input audio data.
        sampleRate    (int)        : The sample rate of the audio.

    Returns: (none)
    """
    
    # Adjust data (-1 and +1) to 16-bit data (-2^15 to +2^15)    
    audioNpArray = np.int16(audioNpArray * (2 ** 15))
    
    # Create AudioSegment object from numpy array
    audioSegmentStereo = pydub.AudioSegment(audioNpArray.tobytes(), 
                                            frame_rate=sampleRate, 
                                            sample_width=2, 
                                            channels=1)
    # Export the AudioSegment object to the specified file
    audioSegmentStereo.export(audioFileName, format="mp3", bitrate="320k")

# Main code for this file
if __name__ == "__main__":
    # Simple test to read in the audio file and write it back out
    print("=> Audio Imported/Export test: ")
    inFilePath = Path("../Audio Files/HEY.mp3")
    outFilePath = Path("../Audio Files/HEY_new.mp3")
    sampleRate, testAudioData = importMP3Audio(inFilePath)
    print("Audio Imported Successfully...")
    exportMP3Audio(outFilePath, testAudioData, sampleRate)
    print("Audio Exported Successfully...")
