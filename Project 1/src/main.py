################################################################################
# Name        : main.py
# Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
# Class       : EE321 (Project 1)
# Due Date    : 2020-09-18
# Description : CDL=> Here Later
################################################################################

# Imports
from common import *
from delay import *
from echo import *
from reverb import *

# CDL=> Remove later. Used for testing Pydub
# CDL=> https://github.com/jiaaro/pydub/blob/master/API.markdown for the Pydub API used
# def importAudio(audioFileName = "In.mp3"):
#     return pydub.AudioSegment.from_mp3(audioFileName)
# def exportAudio(audioSegmentStereo, audioFileName = "Out.mp3"):
#     audioSegmentStereo.export(audioFileName, format="mp3", bitrate="320k")
# def addDelayAudio(audioSegmentStereo, seconds):
#     return pydub.AudioSegment.silent(frame_rate=44100, duration=seconds * 1000) + audioSegmentStereo
# def addEchoAudio(audioSegmentStereo, numberOfEchos, gainStep):
#     out = audioSegmentStereo
#     for i in range(numberOfEchos):
#         out = out + (audioSegmentStereo - (gainStep * (i+1)))
#     return out
# def addReverbAudio(audioSegmentStereo, numberOfEchos, gainStep, delay):
#     out = audioSegmentStereo
#     for i in range(numberOfEchos):
#         out = (audioSegmentStereo - (gainStep * (i+1))).overlay(out, position=(1000 * audioSegmentStereo.duration_seconds * i) + delay)
#     return out
# def testPydubMain()
#     inAudio = importAudio("..\\..\\Audio Files\\HEY.mp3")
#     print("Delaying Audio!")
#     delayedAudio = addDelayAudio(inAudio, 2)
#     exportAudio(delayedAudio, "..\\..\\Audio Files\\HEY_delayed2sec.mp3")
#     print("Adding Echo to Audio!")
#     echoedAudio = addEchoAudio(inAudio, 2, 15)
#     exportAudio(echoedAudio, "..\\..\\Audio Files\\HEY_2echos.mp3")
#     print("Adding Reverb to Audio!")
#     reverbedAudio = addReverbAudio(inAudio, 5, 15, 500)
#     exportAudio(reverbedAudio, "..\\..\\Audio Files\\HEY_2reverb.mp3")

def main():
    """
    Main function to demo audio effects including:
    - Delay
    - Echo
    - Reverb
    
    Parameters: (None)
    Returns:    (None)
    """ 	

    # CDL=> Do stuff here for final design, Not for testing!

if __name__ == "__main__":
    main()

