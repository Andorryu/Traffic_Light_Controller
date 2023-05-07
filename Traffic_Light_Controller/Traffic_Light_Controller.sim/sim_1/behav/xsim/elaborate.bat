@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.2.1 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Wed May 03 16:26:36 -0500 2023
REM SW Build 2729669 on Thu Dec  5 04:49:17 MST 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
echo "xelab -wto 5502bf6c091d46c69e9fd5ee3e480cda --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot traffic_light_controller_behav xil_defaultlib.traffic_light_controller -log elaborate.log"
call xelab  -wto 5502bf6c091d46c69e9fd5ee3e480cda --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot traffic_light_controller_behav xil_defaultlib.traffic_light_controller -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
