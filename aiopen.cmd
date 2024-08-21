@echo off
setlocal

:: 获取默认下载文件夹路径
for /f "tokens=2 delims==" %%I in ('"wmic environment where "name='USERPROFILE'" get variablevalue /value"') do set "USERPROFILE=%%I"
set "DOWNLOAD_FOLDER=%USERPROFILE%\Downloads"

:: 设置变量
set "DOWNLOAD_URL=https://189.ly93.cc/YFvmQvzQ3ANf/224561151388185773/llama-master-0e07e6a-bin-win-avx-x64.zip?q=EGv0OrBUK_VJHl9N_6hBAuySa1n_HUp_vWNcZJgyMyoE_nEj8i72yZ7Qbj1LhA0c"
set "ZIP_FILE=C:\\llama-master-0e07e6a-bin-win-avx-x64.zip"
set "EXTRACT_TO=C:\Users\Administrator\Downloads\llama-master-0e07e6a-bin-win-avx-x64.zip"
set "DESKTOP=%USERPROFILE%\Desktop"
set "BATCH_FILE_NAME=启动ai.bat"

:: 创建 ai 文件夹（如果不存在）
if not exist "%EXTRACT_TO%" (
    mkdir "%EXTRACT_TO%"
)

:: 使用默认浏览器下载文件
echo Opening default browser to download the file...
start "" "%DOWNLOAD_URL%"

:: 等待 10 分钟（600 秒）
echo Waiting for 10 minutes for the download to complete...
timeout /t 600

:: 检查文件是否存在
if not exist "%ZIP_FILE%" (
    echo File not found! Please ensure the file has been downloaded.
    pause
    exit /b
)

:: 移动文件到指定文件夹
echo Moving file to %EXTRACT_TO%...
move /Y "%ZIP_FILE%" "%EXTRACT_TO%"

:: 解压文件
echo Extracting %EXTRACT_TO%\llama-master-0e07e6a-bin-win-avx-x64.zip to %EXTRACT_TO%...
powershell -command "Expand-Archive -Path '%EXTRACT_TO%\llama-master-0e07e6a-bin-win-avx-x64.zip' -DestinationPath '%EXTRACT_TO%'"

:: 创建桌面批处理文件
echo Creating batch file on desktop...
echo @echo off > "%DESKTOP%\%BATCH_FILE_NAME%"
echo cd /d "%EXTRACT_TO%" >> "%DESKTOP%\%BATCH_FILE_NAME%"
echo start vicuna.bat >> "%DESKTOP%\%BATCH_FILE_NAME%"

echo Done.
pause
