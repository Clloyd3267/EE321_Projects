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

# CDL=> How do we deal with stereo/mono? Do we want all audio tracks to be 
#       treated as a single channel mono and just operate on one? Or should we 
#       deal with stereo also? 
# CDL=> Seems like we just use mono audio which needs to be changed

def importMP3Audio(audioFileName, normalized=False):
    """
    Function to import audio from an MP3 file and convert it to a Numpy array.

    Description: Imports MP3 data using FFMPEG and Pydub to create an 
                 AudioSegment object which gets converted to a Numpy array. 
                 This array can be normalized from (-1 and +1) depending on
                 (normalized).

    Parameters:
        audioFileName (string): The input MP3 audio file name.
        normalized    (bool)  : Whether the data should be normalized.

    Returns:
        (int)        : The sample rate of the audio.
        (Numpy Array): The audio data which can be normalized.
    """

    audioSegmentStereo = pydub.AudioSegment.from_mp3(audioFileName)
    audioNpArray = np.array(audioSegmentStereo.get_array_of_samples())

    # If stereo (2 channel), Split 1D array to 2 rows and N columns depending
    # on the number of samples.
    if audioSegmentStereo.channels == 2:
        audioNpArray = audioNpArray.reshape((-1, 2))
    
    # If user specifies normalized data, reformat to floats between (-1 and +1)
    if normalized:
        return audioSegmentStereo.frame_rate, np.float32(audioNpArray) / 2**15
    else:
        return audioSegmentStereo.frame_rate, audioNpArray

def exportMP3Audio(audioFileName, audioNpArray, sampleRate, normalized=False):
    """
    Function to export audio from a Numpy array and convert it to a MP3 file.
    
    Description: 
        Exports MP3 data using FFMPEG and Pydub from an 
        AudioSegment object which gets converted from a Numpy array. 
        This array may be normalized from (-1 and +1) which can be  
        specified using (normalized).

    Parameters:
        audioFileName (string)     : The output MP3 audio file name.
        audioNpArray  (Numpy Array): The input audio data.
        sampleRate    (int)        : The sample rate of the audio.
        normalized    (bool)       : Whether the data has been normalized.

    Returns: (none)
    """
    
    # Adjust for Stereo or Mono Audio
    channels = 2 if (audioNpArray.ndim==2 and audioNpArray.shape[1]==2) else 1
    
    # If user specifies normalized data, adjust from floats between
    # (-1 and +1) to 16-bit data (-2^15 to +2^15)    
    if normalized:
        audioNpArray = np.int16(audioNpArray * (2 ** 15))
    else:
        audioNpArray = np.int16(audioNpArray)

    # Create AudioSegment object from numpy array
    audioSegmentStereo = pydub.AudioSegment(audioNpArray.tobytes(), 
                                            frame_rate=sampleRate, 
                                            sample_width=2, 
                                            channels=channels)
    # Export the AudioSegment object to the specified file
    audioSegmentStereo.export(audioFileName, format="mp3", bitrate="320k")

# Main code for this file
if __name__ == "__main__":
    # Simple test to read in the audio file and write it back out
    print("=> Audio Imported/Export test: ")
    inFilePath = Path("../Audio Files/HEY.mp3")
    outFilePath = Path("../Audio Files/HEY_new.mp3")
    sampleRate, testAudioData = importMP3Audio(inFilePath, True)
    print("Audio Imported Successfully...")
    testAudio = exportMP3Audio(outFilePath, testAudioData, sampleRate, True)
    print("Audio Exported Successfully...")
