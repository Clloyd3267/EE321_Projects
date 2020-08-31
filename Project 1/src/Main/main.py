################################################################################
# Name        : main.py
# Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
# Class       : EE321 (Project 1)
# Due Date    : 2020-09-18
# Description : CDL=> Here Later
################################################################################

# Imports
import pydub 
import numpy as np

def importAudio(audioFileName = "In.mp3"):
    return pydub.AudioSegment.from_mp3(audioFileName)
    # audioSegmentMonoChannels = audioSegmentStereo.split_to_mono()

    # a = pydub.AudioSegment.from_mp3(f)
    # y = np.array(a.get_array_of_samples())
    # if a.channels == 2:
    #     y = y.reshape((-1, 2))
    # if normalized:
    #     return a.frame_rate, np.float32(y) / 2**15
    # else:
    #     return a.frame_rate, y

def exportAudio(audioSegmentStereo, audioFileName = "Out.mp3"):
    # """numpy array to MP3"""
    # channels = 2 if (x.ndim == 2 and x.shape[1] == 2) else 1
    # if normalized:  # normalized array - each item should be a float in [-1, 1)
    #     y = np.int16(x * 2 ** 15)
    # else:
    #     y = np.int16(x)
    # song = pydub.AudioSegment(y.tobytes(), frame_rate=sr, sample_width=2, channels=channels)
    audioSegmentStereo.export(audioFileName, format="mp3", bitrate="320k")

def addDelayAudio(audioSegmentStereo, seconds):
    return pydub.AudioSegment.silent(frame_rate=44100, duration=seconds * 1000) + audioSegmentStereo

def addEchoAudio(audioSegmentStereo, numberOfEchos, gainStep):
    out = audioSegmentStereo

    for i in range(numberOfEchos):
        out = out + (audioSegmentStereo - (gainStep * (i+1)))

    return out

def addReverbAudio(audioSegmentStereo, numberOfEchos, gainStep, delay):
    out = audioSegmentStereo

    for i in range(numberOfEchos):
        out = (audioSegmentStereo - (gainStep * (i+1))).overlay(out, position=(1000 * audioSegmentStereo.duration_seconds * i) + delay)

    return out


def main():
    """
    Main function to demo audio effects including:
    - Delay
    - Echo
    - Reverb
    
    Parameters: (None)
    Returns:    (None)
    """ 	
    print("Delaying Audio!")
    inAudio = importAudio("..\\..\\Audio Files\\HEY.mp3")
    delayedAudio = addDelayAudio(inAudio, 2)
    exportAudio(delayedAudio, "..\\..\\Audio Files\\HEY_delayed2sec.mp3")

    echoedAudio = addEchoAudio(inAudio, 2, 15)
    exportAudio(echoedAudio, "..\\..\\Audio Files\\HEY_2echos.mp3")

    reverbedAudio = addReverbAudio(inAudio, 5, 15, 500)
    exportAudio(reverbedAudio, "..\\..\\Audio Files\\HEY_2reverb.mp3")
    

    # audioSegmentStereo = pydub.AudioSegment.from_mp3("..\\..\\Audio Files\\HEY.mp3")
    # audioSegmentMonoChannels = audioSegmentStereo.split_to_mono()
    
    # y = np.array(a.get_array_of_samples())
    # if a.channels == 2:
    #     y = y.reshape((-1, 2))
    # if normalized:
    #     return a.frame_rate, np.float32(y) / 2**15
    # else:
    #     return a.frame_rate, y         

if __name__ == "__main__":
    main()

