# 3D Human Pose Estimation

This program is remodeled by moazzem (munnam77) forking [3d-pose-baseline](https://github.com/ArashHosseini/3d-pose-baseline/).

Please check the above URL or [README-ArashHosseini.md](README-ArashHosseini.md) for details of operation.

## Functional overview

- [Generates](https://github.com/CMU-Perceptual-Computing-Lab/openpose) a 3D human model from the human skeleton detected by [OpenPose](https://github.com/CMU-Perceptual-Computing-Lab/openpose).
- Output joint data when generating 3D human model
    	- By reading joint data with [3d-pose-baseline-motion](https://github.com/miu200521358/VMD-3d-pose-baseline-multi)
- Analyze OpenPose data for multiple people.
    	- Try to analysis for only one person.
    	- Ver2.00 is now supports multiple people tracing. Please check [FCRN-DepthPrediction-vmd](https://github.com/miu200521358/FCRN-DepthPrediction-vmd) for details.

### Dependencies

Install the following in python3 series

* [h5py](http://www.h5py.org/)
* [tensorflow](https://www.tensorflow.org/) 1.0 or later

### H36M data

3D skeleton information is created based on [Human3.6M](http://vision.imar.ro/human3.6m/description.php). 
Download the compressed file from below, decompress it, and place it under `data`.

[H36M Data zip (Dropbox)](https://www.dropbox.com/s/e35qv3n6zlkouki/h36m.zip) 

### Learning data

Since the original learning data hits the 260 character path limit of Windows, the path was simplified and regenerated.
Download the compressed file below, unzip it, and place it under `experiments`.

[Learning data zip (GoogleDrive)](https://drive.google.com/file/d/1v7ccpms3ZR8ExWWwVfcSpjMsGscDYH7_/view?usp=sharing) 

## Execution method

1. Analyze data with [Openpose Simple Launch Batch](https://github.com/munnam77/openpose-simple)
2. Generate data by depth estimation and person index with [Depth Estimation](https://github.com/munnam77/FCRN-DepthPrediction-vmd)
1. Run [OpenposeTo3D.bat] (OpenposeTo3D.bat)
1. You will be asked `Directory path by INDEX`, so specify the full path of` Path by person index` in 2.
	-`{Video file name} _json_ {Execution date and time} _index {Order from the left of the 0th floor}}
	-For multiple traces, separate execution is required
1. You will be asked if you want to `detailed log`. If you want to do so, enter` yes`
    -If not specified or `no`, normal log (each parameter file and 3D animated GIF)
    -In the case of `warn`, 3D animation GIF is not generated.
    -If `yes`, a detailed log is output, and a debug image is output in addition to the log message (slowly)
1. Start processing
1. When the process is completed, the following results are output in the `Person-by-person index path 'in 3.
    -pos.txt… Joint data of all frames (required for [VMD-3d-pose-baseline-multi](https://github.com/miu200521358/VMD-3d-pose-baseline-multi)) Details: [Output ](doc / Output.md)
    -start_frame.txt… Start frame index (required for [VMD-3d-pose-baseline-multi](https://github.com/miu200521358/VMD-3d-pose-baseline-multi) 
    -smoothed.txt ... 2D position data for all frames (required for [VMD-3d-pose-baseline-multi](https://github.com/miu200521358/VMD-3d-pose-baseline-multi)) Details: [ Output](doc / Output.md)
    -movie_smoothing.gif… Animated GIF combining postures for each frame
    -smooth_plot.png… A graph with smooth movement
    -frame3d / tmp_0000000000xx.png… 3D posture of each frame
    -frame3d / tmp_0000000000xx_xxx.png… 3D posture by angle of each frame (only when detailed log is yes)

## Important point

-Do not use a 12-digit number string in the Openson json arbitrary file name.
    -To extract a 12-digit number as the frame number from the file name `{arbitrary file name} _ {frame number} _keypoints.json`, like` short02_000000000000_keypoints.json`

## License
MIT
