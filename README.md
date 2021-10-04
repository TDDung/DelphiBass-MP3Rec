# DelphiBass-MP3Rec
Delphi demo that uses BASS library and add-ons to record MP3

Hi,

This is a quick-and-dirty demo to show how to use BASS audio library's add-ons to record MP3 audio data. It runs on all 5 supported platforms Windows, MacOS, Linux, Android and iOS.

Please note:

- Only necessary files from Delphi-BASS are used in this demo thus the others are not included
- Although Delphi-BASS allows both VCL and FMX frameworks, I only use FMX to make this demo multi-platform
- This demo is not compatible with Delphi 11 and Android 11 due to some changes in language and Android Permission Model (It is not difficult to solve at all, however)
- The MP3 audio file is saved but not played back as that's not the purpose of this demo :) although you can easily do so using Delphi-BASS

Brief description about BASS audio library
------------------------------------------
(See more in www.un4seen.com)

BASS is an audio library for use in software on several platforms. Its purpose is to provide developers with powerful and efficient sample, stream (MP3, MP2, MP1, OGG, WAV, AIFF, custom generated, and more via OS codecs and add-ons), MOD music (XM, IT, S3M, MOD, MTM, UMX), MO3 music (MP3/OGG compressed MODs), and recording functions. All in a compact DLL that won't bloat your distribution.
BASS is also available for the Android, iOS, UWP, WinCE, and ARM Linux platforms.

Note: All the DLL files can be downloaded directly from www.un4seen.com instead. There are just many of them, though, so just make sure you choose the correct ones to replace what's in my package and of course test, test and test :-)
