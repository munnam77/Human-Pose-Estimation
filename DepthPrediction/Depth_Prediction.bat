@echo off
rem --- 
rem ---  Perform depth estimation from video data
rem --- 

rem ---  Change the current directory to the execution destination
cd /d %~dp0

rem ---  Input target video file path
echo Please enter the full path of the file of the video analyzed with Openpose.
set INPUT_VIDEO=
set /P INPUT_VIDEO=** Video file path to be analyzed: 
rem echo INPUT_VIDEOÅF%INPUT_VIDEO%

IF /I "%INPUT_VIDEO%" EQU "" (
    ECHO Processing is suspended because the analysis target video file path is not set.
    EXIT /B
)

rem ---  Analysis result JSON directory path
echo Please enter the full path of JSON directory of analysis result of Openpose.
set OPENPOSE_JSON=
set /P OPENPOSE_JSON=** Analysis result JSON directory path: 
rem echo OPENPOSE_JSONÅF%OPENPOSE_JSON%

IF /I "%OPENPOSE_JSON%" EQU "" (
    ECHO Analysis result Since JSON directory path is not set, processing is interrupted.
    EXIT /B
)

rem ---  Depth estimation interval
echo --------------
set DEPTH_INTERVAL=10
echo Please enter the interval of the frame to be estimated depth.
echo The smaller the value, the finer the depth estimation. (It takes time to do so)
echo If nothing is entered and ENTER is pressed, processing is done at the interval of "%DEPTH_INTERVAL%".
set /P DEPTH_INTERVAL="** Depth estimation interval: "

rem ---  Flip frame list
echo --------------
set REVERSE_FRAME_LIST=
echo Please specify the frame number (0 start) that Openpose misrecognized and flipped.
echo A reversing judgment is made for the frame with the number specified here, and if reverse verification is done, the joint position will be reversed.
echo Multiple items can be specified with a comma. In addition, the range can be specified with a hyphen.
echo Ex.) 4,10-12 ... 4,10,11,12 are the inverted judgment target frame.
set /P REVERSE_FRAME_LIST="** Flip frame list: "

rem ---  Sequential list
echo --------------
set ORDER_SPECIFIC_LIST=
echo Please specify the person INDEX order after crossing with multiple person trace.
echo 0F Counts as 0th, 1st, in order from the left of the standing position.
echo Format: [<frame number>: index of the 0 th person from the left, 1st from the left ...]
echo Example) [10: 1, 0] ... 10F sort in order of the first person from the left and the 0th person.
echo Multiple items can be specified in parentheses as [10: 1, 0] [30: 0, 1].
echo Example) [10-15: 1, 0] [10: 0, 1] ... 10 to 15F Eye: 1, 0 order, 30F eye: 0, 1 order.
set /P ORDER_SPECIFIC_LIST="** Sequential list: "

rem ---  Presence of detailed log

echo --------------
echo Please output detailed logs or enter yes or no.
echo If nothing is entered and ENTER is pressed, normal log and depth estimation GIF are output.
echo If warn is specified, animation GIF is not output. (That is earlier)
set VERBOSE=2
set IS_DEBUG=no
set /P IS_DEBUG="** Detailed log[yes/no/warn]: "

IF /I "%IS_DEBUG%" EQU "yes" (
    set VERBOSE=3
)

IF /I "%IS_DEBUG%" EQU "warn" (
    set VERBOSE=1
)

rem ---  python Execution
python tensorflow/depth_prediction.py --model_path tensorflow/data/NYU_FCRN.ckpt --video_path %INPUT_VIDEO% --json_path %OPENPOSE_JSON% --interval %DEPTH_INTERVAL% --reverse_frames "%REVERSE_FRAME_LIST%" --order_specific "%ORDER_SPECIFIC_LIST%" --verbose %VERBOSE%


