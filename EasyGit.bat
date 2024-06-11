@echo off
:menu
echo TODO repo laden met git clone url
echo.
echo 1) Easy commit
echo 2) Verwijder veranderingen / Laad cloud repo
echo 3) Maak tak
echo 4) Verander naar tak
echo 5) Lijst van alle takken
echo 6) Easy Commit with Msg
echo 7) Annuleer
set /p choice="Optie: "

if "%choice%"=="1" goto sync_repo
if "%choice%"=="2" goto reload_repo
if "%choice%"=="3" goto create_branch
if "%choice%"=="4" goto switch_branch
if "%choice%"=="5" goto list_branches
if "%choice%"=="6" goto custom_commit
if "%choice%"=="7" goto exit
echo Optie bestaat niet
goto menu

:sync_repo
git pull origin main
git add .
git commit -m "EasyGit"
git push origin main
echo Sync Voltooid
goto menu

:reload_repo
git reset --hard
git clean -fd
git pull origin main
echo Cloud repo geladen
goto menu

:create_branch
set /p branch_name="Nieuwe Tak naam: "
git checkout -b %branch_name%
git push origin %branch_name%
echo Nieuwe tak '%branch_name%' is gemaakt en gesyncd met cloud
goto menu

:switch_branch
set /p branch_name="Naar welke tak wisselen: "
git checkout %branch_name%
echo Naar tak gewisseld: '%branch_name%'.
goto menu

:list_branches
git branch -a
goto menu

:custom_commit
set /p commit_msg="custom commit bericht: "
git add .
git commit -m "%commit_msg%"
git push origin %cd%
echo Veranderingen Synced '%commit_msg%'.
goto menu

:exit
exit /b