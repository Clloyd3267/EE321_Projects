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
import matplotlib.pyplot as plt
import numpy as np

def expandPlotInNewFigure(event):
    """
    Function to open new figure with selected plot's data.

    Parameters:
        event (Matplotlib Event) : The event that contains the selected plot.

    Returns:
    """    
    if event.inaxes is not None:
        axe = event.inaxes

        # Create a new figure and subplot
        newFig, axe1 = plt.subplots()
        newFig.canvas.set_window_title("Expanded Plot")

        # Add plot data
        oldPlotData = list(axe.get_lines())[0]
        axe1.plot(oldPlotData.get_data()[0], oldPlotData.get_data()[1])

        # Set plot settings
        axe1.set_title(axe.get_title())
        axe1.set_xlabel("Time (s)")
        axe1.set_ylabel("Amplitude")
        axe1.grid(True)

        # Display figure
        newFig.show()

def main():
    """
    Main function to demo audio effects including:
    - Delay
    - Echo
    - Reverb

    Parameters: (None)
    Returns:    (None)
    """

    ############################################################################
    # ============================> Import Audio <=============================#
    ############################################################################  
    inFilePath = Path("../Audio Files/JUST_HEY.mp3")
    sampleRate, originalAudioData = importMP3Audio(inPath, True)

    ############################################################################
    # ==========================> Add Delay to Audio <=========================#
    ############################################################################

    # Get Audio with Delay
    delayed1SecAudioData = delay(originalAudioData, sampleRate, 1)
    delayed2SecAudioData = delay(originalAudioData, sampleRate, 2)
    delayed3SecAudioData = delay(originalAudioData, sampleRate, 3)

    # Export Audio
    delayed1SecOutPath = Path("../Audio Files/HEY_1sec_delay.mp3")
    delayed2SecOutPath = Path("../Audio Files/HEY_2sec_delay.mp3")
    delayed3SecOutPath = Path("../Audio Files/HEY_3sec_delay.mp3")
    exportMP3Audio(delayed1SecOutPath, delayed1SecAudioData, sampleRate, True)
    exportMP3Audio(delayed2SecOutPath, delayed2SecAudioData, sampleRate, True)
    exportMP3Audio(delayed3SecOutPath, delayed3SecAudioData, sampleRate, True)

    # Create figure and plots
    delayFig, (originalAxes, 
               delay1SecAxes, 
               delay2SecAxes, 
               delay3SecAxes) = plt.subplots(4)
    delayFig.suptitle("Adding Delay to an Audio Sample")
    delayFig.canvas.set_window_title("Adding Delay to an Audio Sample")

    # Set general plot settings for each subplot
    for axe in [originalAxes, delay1SecAxes, delay2SecAxes, delay3SecAxes]:
        axe.set_xlabel("Time (s)")
        axe.set_ylabel("Amplitude")
        axe.set_xlim(0, 6)              # Set x axis from 0 - 6 seconds # CDL=> What value here? Variable?
        axe.set_ylim(-1, 1)             # Set y axis from -1 to 1
        axe.grid(True)

    # Set plot titles
    originalAxes.set_title("Original Audio")
    delay1SecAxes.set_title("Audio With 1 Second Delay")
    delay2SecAxes.set_title("Audio With 2 Second Delay")
    delay3SecAxes.set_title("Audio With 3 Second Delay")

    # Scale axis to time using sample rate
    originalXAxis  = np.arange(len(originalAudioData))    / sampleRate
    delay1SecXAxis = np.arange(len(delayed1SecAudioData)) / sampleRate
    delay2SecXAxis = np.arange(len(delayed2SecAudioData)) / sampleRate
    delay3SecXAxis = np.arange(len(delayed3SecAudioData)) / sampleRate

    # Add plot data
    originalAxes.plot(originalXAxis, originalAudioData)
    delay1SecAxes.plot(delay1SecXAxis, delayed1SecAudioData)
    delay2SecAxes.plot(delay2SecXAxis, delayed2SecAudioData)
    delay3SecAxes.plot(delay3SecXAxis, delayed3SecAudioData)
    
    # Figure settings
    delayFig.canvas.mpl_connect("button_press_event", expandPlotInNewFigure)
    delayFig.tight_layout()

    ############################################################################
    # ==========================> Add Echo to Audio <==========================#
    ############################################################################

    # Get Audio with Echo
    gainChange = 0.7
    echo1AudioData = echo(originalAudioData, 1, gainChange)
    echo2AudioData = echo(originalAudioData, 2, gainChange)
    echo3AudioData = echo(originalAudioData, 3, gainChange)

    # Export Audio
    echo1OutPath = Path("../Audio Files/HEY_1_echos.mp3")
    echo2OutPath = Path("../Audio Files/HEY_2_echos.mp3")
    echo3OutPath = Path("../Audio Files/HEY_3_echos.mp3")
    exportMP3Audio(echo1OutPath, echo1AudioData, sampleRate, True)
    exportMP3Audio(echo2OutPath, echo2AudioData, sampleRate, True)
    exportMP3Audio(echo3OutPath, echo3AudioData, sampleRate, True)

    # Create figure and plots
    echoFig, (originalAxes, 
              echo1Axes, 
              echo2Axes, 
              echo3Axes) = plt.subplots(4)
    echoFig.suptitle("Adding Echo to an Audio Sample")
    echoFig.canvas.set_window_title("Adding Echo to an Audio Sample")

    # Set general plot settings for each subplot
    for axe in [originalAxes, echo1Axes, echo2Axes, echo3Axes]:
        axe.set_xlabel("Time (s)")
        axe.set_ylabel("Amplitude")
        axe.set_xlim(0, 6)              # Set x axis from 0 - 6 seconds # CDL=> What value here? Variable?
        axe.set_ylim(-1, 1)             # Set y axis from -1 to 1
        axe.grid(True)

    # Set plot titles
    originalAxes.set_title("Original Audio")
    echo1Axes.set_title("Audio With 1 Echo")
    echo2Axes.set_title("Audio With 2 Echoes")
    echo3Axes.set_title("Audio With 3 Echoes")

    # Scale axis to time using sample rate
    originalXAxis = np.arange(len(originalAudioData)) / sampleRate
    echo1XAxis    = np.arange(len(echo1AudioData))    / sampleRate
    echo2XAxis    = np.arange(len(echo2AudioData))    / sampleRate
    echo3XAxis    = np.arange(len(echo3AudioData))    / sampleRate

    # Add plot data
    originalAxes.plot(originalXAxis, originalAudioData)
    echo1Axes.plot(echo1XAxis, echo1AudioData)
    echo2Axes.plot(echo2XAxis, echo2AudioData)
    echo3Axes.plot(echo3XAxis, echo3AudioData)
    
    # Figure settings
    echoFig.canvas.mpl_connect("button_press_event", expandPlotInNewFigure)
    echoFig.tight_layout()

    ############################################################################
    # ==========================> Add Reverb to Audio <========================#
    ############################################################################

    # Get Audio with reverb
    gainChange = 0.7
    delayTimeSec = 0.1
    reverb1AudioData = reverb(originalAudioData, 1, sampleRate, delayTimeSec, gainChange)
    reverb2AudioData = reverb(originalAudioData, 2, sampleRate, delayTimeSec, gainChange)
    reverb3AudioData = reverb(originalAudioData, 3, sampleRate, delayTimeSec, gainChange)

    # Export Audio
    reverb1OutPath = Path("../Audio Files/HEY_1_reverb.mp3")
    reverb2OutPath = Path("../Audio Files/HEY_2_reverb.mp3")
    reverb3OutPath = Path("../Audio Files/HEY_3_reverb.mp3")
    exportMP3Audio(reverb1OutPath, reverb1AudioData, sampleRate, True)
    exportMP3Audio(reverb2OutPath, reverb2AudioData, sampleRate, True)
    exportMP3Audio(reverb3OutPath, reverb3AudioData, sampleRate, True)

    # Create figure and plots
    reverbFig, (originalAxes, 
              reverb1Axes, 
              reverb2Axes, 
              reverb3Axes) = plt.subplots(4)
    reverbFig.suptitle("Adding Reverb to an Audio Sample")
    reverbFig.canvas.set_window_title("Adding Reverb to an Audio Sample")

    # Set general plot settings for each subplot
    for axe in [originalAxes, reverb1Axes, reverb2Axes, reverb3Axes]:
        axe.set_xlabel("Time (s)")
        axe.set_ylabel("Amplitude")
        axe.set_xlim(0, 6)              # Set x axis from 0 - 6 seconds # CDL=> What value here? Variable?
        axe.set_ylim(-1, 1)             # Set y axis from -1 to 1
        axe.grid(True)

    # Set plot titles
    originalAxes.set_title("Original Audio")
    reverb1Axes.set_title("Audio With 1 Reverb")
    reverb2Axes.set_title("Audio With 2 Reverb Echoes")
    reverb3Axes.set_title("Audio With 3 Reverb Echoes")

    # Scale axis to time using sample rate
    originalXAxis = np.arange(len(originalAudioData)) / sampleRate
    reverb1XAxis  = np.arange(len(reverb1AudioData))  / sampleRate
    reverb2XAxis  = np.arange(len(reverb2AudioData))  / sampleRate
    reverb3XAxis  = np.arange(len(reverb3AudioData))  / sampleRate

    # Add plot data
    originalAxes.plot(originalXAxis, originalAudioData)
    reverb1Axes.plot(reverb1XAxis, reverb1AudioData)
    reverb2Axes.plot(reverb2XAxis, reverb2AudioData)
    reverb3Axes.plot(reverb3XAxis, reverb3AudioData)
    
    # Figure settings
    reverbFig.canvas.mpl_connect("button_press_event", expandPlotInNewFigure)
    reverbFig.tight_layout()
    
    # Show Figures
    plt.show()

if __name__ == "__main__":
    main()
