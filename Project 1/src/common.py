# CDL=> Reformat with file header, function headers..
# CDL=> Use PathLib
import pydub 
import numpy as np

# CDL=> How do we deal with stereo/mono? Do we want all audio tracks to be 
#       treated as a single channel mono and just operate on one? Or should we 
#       deal with stereo also?
# CDL=> https://github.com/jiaaro/pydub/blob/master/API.markdown is a good resource for Pydub functionality. I'd give it a read
# CDL=> Rename variables to be more clear on their type.

def importAudio(audioFileName, normalized=False):
    """MP3 to numpy array"""
    a = pydub.AudioSegment.from_mp3(audioFileName)
    y = np.array(a.get_array_of_samples())
    # Look into using AudioSegment.split_to_mono()
    # look into https://github.com/jiaaro/pydub/blob/master/API.markdown#audiosegmentget_array_of_samples for examples
    if a.channels == 2:
        y = y.reshape((-1, 2))
    # Do we need to normalize it? Else we could just use "y" from above
    if normalized:
        return a.frame_rate, np.float32(y) / 2**15
    else:
        return a.frame_rate, y

def exportAudio(audioFileName, sr, x, normalized=False):
    """numpy array to MP3"""
    channels = 2 if (x.ndim == 2 and x.shape[1] == 2) else 1
    # Do we need to normalize it? Else we could just use "y" from above
    if normalized:  # normalized array - each item should be a float in [-1, 1)
        y = np.int16(x * 2 ** 15)
    else:
        y = np.int16(x)
    song = pydub.AudioSegment(y.tobytes(), frame_rate=sr, sample_width=2, channels=channels)
    song.export(audioFileName, format="mp3", bitrate="320k")

if __name__ == "__main__":
    # CDL=> Add test code here
    print("Hello World!")