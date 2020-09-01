################################################################################
# Name        : delay.py
# Author(s)   : Kyle Bielby, Chris Lloyd, Stephen Epp, Philip Hubbe
# Class       : EE321 (Project 1)
# Due Date    : 2020-09-18
# Description : CDL=> Here Later
################################################################################

# Imports
from common import * # CDL=> Remove later, only for testing!
import numpy as np

# def delay(audioData):
#     """
#     Function to add delay to audio.
#
#     Parameters:
#         audioData (CDL=> What type?): The input audio.
#
#     Returns:
#         (0): No errors, (Anything else): Errors.
#     """

##########Kyle Bielby: delay function that uses numpy array functions#################
# Description: function that takes numpy array representing an
#   audio file and adds a delay to the numpy array
# delayPeriod: determines delay in seconds used for audio file
# sampleRate: determines the sample rate used to form the delay
# audioData: numpy array that represents audio file
# author: Kyle Bielby
def delay(delayPeriod, sampleRate, audioData):
    zeros = delayPeriod * sampleRate    #compute number of zeros to prepend to numpy array

    #prepend zeros to numpy array to cause delay for x seconds
    for x in range(zeros):
        audioData = np.insert(audioData, 0, x, axis=0)

    return audioData    #return delayed numpy array
##########Kyle Bielby: end of numpy array functions#####################################

# Main code for this file
if __name__ == "__main__":
    # CDL=> Add test code here
    print("Hello World!")
