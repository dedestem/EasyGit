@echo off

:: Controleer of Git is geïnstalleerd
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git is niet geïnstalleerd op dit systeem.
    set /p install_git="Wilt je Git installeren? (j/n): "
    if /i "%install_git%"=="j" goto install_git
    echo Git is vereist voor dit script.
    pause
    exit /b
)

goto menu

:menumain
pause

:menu
cls
echo.
echo Beheer van Repository
echo.
echo 1) Kloon Repository
echo 2) Verwijder veranderingen
echo 3) Status Controle
echo 4) Haal Updates op
echo 5) Haal Laatste Wijzigingen op
echo 6) Toon Commit Geschiedenis
echo 7) Toon Verschillen
echo.
echo Commit Functies
echo.
echo 8) Eenvoudige commit
echo 9) Eenvoudige Commit met Bericht
echo.
echo Tak Functies
echo.
echo 10) Maak Tak
echo 11) Verander naar Tak
echo 12) Lijst van Alle Takken
echo 13) Voeg Takken Samen
echo 14) Verwijder Tak
echo.
echo lokaal concept
echo.
echo 15) concept opslaan
echo 16) laad concept lokaal in
echo.
echo git functies
echo.
echo 17) Login bij GitHub
echo 18) git versie
echo.
echo Overige Functies
echo.
echo 19) Uitleg Functies
echo 20) Beheer EasyGit
echo 21) Sluit EasyGit
set /p choice="Optie: "

if "%choice%"=="1" goto clone_repo
if "%choice%"=="2" goto reload_repo
if "%choice%"=="3" goto status_check
if "%choice%"=="4" goto fetch_updates
if "%choice%"=="5" goto pull_latest
if "%choice%"=="6" goto show_history
if "%choice%"=="7" goto show_differences
if "%choice%"=="8" goto auto_commit
if "%choice%"=="9" goto custom_commit
if "%choice%"=="10" goto create_branch
if "%choice%"=="11" goto change_branch
if "%choice%"=="12" goto list_branch
if "%choice%"=="13" goto merge_branches
if "%choice%"=="14" goto delete_branch
if "%choice%"=="15" goto stash_changes
if "%choice%"=="16" goto apply_stash
if "%choice%"=="17" goto login_github
if "%choice%"=="18" goto git_ver
if "%choice%"=="19" goto explain_functions
if "%choice%"=="20" goto beheer_easygit
if "%choice%"=="21" goto exit
echo Optie bestaat niet
goto menumain

:git_ver
echo Git versie:
git --version
goto menumain

:beheer_easygit
echo EasyGit Versie 1
goto menumain


:auto_commit
git pull origin main
git add .
git commit -m "EasyGit"
git push origin main
echo Sync Voltooid
goto menumain

:reload_repo
git reset --hard
git clean -fd
git pull origin main
echo Cloud repo geladen
goto menumain

:create_branch
set /p branch_name="Nieuwe Tak naam: "
git checkout -b %branch_name%
git push origin %branch_name%
echo Nieuwe tak '%branch_name%' is gemaakt en gesynchroniseerd met cloud
goto menumain

:change_branch
set /p branch_name="Naar welke tak wilt u wisselen: "
git checkout %branch_name%
echo Naar tak gewisseld: '%branch_name%'.
goto menumain

:list_branch
git branch -a
goto menumain

:custom_commit
set /p commit_msg="Aangepast commit bericht: "
git add .
git commit -m "%commit_msg%"
git push origin main
echo Wijzigingen gesynchroniseerd met commit bericht '%commit_msg%'.
goto menumain

:login_github
set /p username="GitHub Gebruikersnaam: "
set /p password="GitHub Wachtwoord: "
echo https://%username%:%password%@github.com > %HOMEPATH%\.git-credentials
git config --global credential.helper store
echo Inloggegevens opgeslagen.
goto menumain

:clone_repo
set /p repo_url="Geef de URL van de repository: "
git clone %repo_url%
echo Repository gekloond.
goto menumain

:fetch_updates
git fetch
echo Updates opgehaald.
goto menumain

:pull_latest
git pull origin main
echo Laatste wijzigingen opgehaald.
goto menumain

:show_history
git log
goto menumain

:show_differences
git diff
goto menumain

:merge_branches
set /p source_branch="Welke tak wil je samenvoegen: "
set /p target_branch="In welke tak wil je samenvoegen: "
git checkout %target_branch%
git merge %source_branch%
echo Tak '%source_branch%' is samengevoegd in '%target_branch%'.
goto menumain

:delete_branch
set /p branch_name="Welke tak wilt u verwijderen: "
git branch -d %branch_name%
git push origin --delete %branch_name%
echo Tak '%branch_name%' is verwijderd.
goto menumain

:status_check
git status
goto menumain

:stash_changes
git stash
echo Wijzigingen verborgen.
goto menumain

:apply_stash
git stash apply
echo Verborgen wijzigingen toegepast.
goto menumain

:explain_functions
cls
echo ====== Uitleg van Functies ======
echo.
echo 1) Kloon Repository:
echo    Deze functie vraagt om de URL van een Git repository en kloont deze naar uw huidige map.
echo.
echo 2) Verwijder veranderingen:
echo    Deze functie reset de werkruimte naar de laatste commit en verwijdert onbeheerde bestanden en mappen.
echo.
echo 3) Status Controle:
echo    Toont de huidige status van de werkruimte, inclusief gewijzigde, toegevoegde en verwijderde bestanden.
echo.
echo 4) Haal Updates op:
echo    Haalt de nieuwste referenties op van de remote repository, zonder de wijzigingen in de werkruimte bij te werken.
echo.
echo 5) Haal Laatste Wijzigingen op:
echo    Haalt de laatste wijzigingen op van de remote repository en past deze toe op de huidige werkruimte.
echo.
echo 6) Toon Commit Geschiedenis:
echo    Toont een beknopt overzicht van de commit geschiedenis van de huidige branch.
echo.
echo 7) Toon Verschillen:
echo    Toont de verschillen tussen de huidige werkruimte en de laatste commit.
echo.
echo 8) Eenvoudige commit:
echo    Voegt alle gewijzigde bestanden toe aan de staging area, maakt een commit met de standaard bericht "EasyGit" en pusht naar de remote repository.
echo.
echo 9) Eenvoudige Commit met Bericht:
echo    Voegt alle gewijzigde bestanden toe aan de staging area, maakt een commit met een aangepast bericht en pusht naar de remote repository.
echo.
echo 10) Maak Tak:
echo    Vraagt om een nieuwe taknaam, maakt een nieuwe lokale tak en pusht deze naar de remote repository.
echo.
echo 11) Verander naar Tak:
echo    Vraagt om een bestaande taknaam en wisselt naar deze tak.
echo.
echo 12) Lijst van Alle Takken:
echo    Toont een lijst van alle lokale en remote takken.
echo.
echo 13) Voeg Takken Samen:
echo    Vraagt om een brontak en doeltak, wisselt naar de doeltak en voegt de brontak samen in de doeltak.
echo.
echo 14) Verwijder Tak:
echo    Vraagt om een taknaam, verwijdert de lokale tak en, indien gewenst, de tak van de remote repository.
echo.
echo 15) sla concept op
echo    Stasht alle huidige wijzigingen (zonder te committen), zodat deze later kunnen worden toegepast.
echo.
echo 16) laad concept
echo    Past de laatst gestashte wijzigingen toe op de huidige werkruimte.
echo.
echo 17) Login bij GitHub:
echo    Vraagt om GitHub gebruikersnaam en wachtwoord, slaat deze op voor authenticatie bij GitHub en configureert Git om deze referenties te onthouden.
echo.
echo 18) Uitleg Functies:
echo    Toont dit bericht
echo.
echo.
goto menumain

:exit 
exit