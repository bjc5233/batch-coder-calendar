@echo off& mode 86,36& call loadE.bat CurS echox image setWT& call load.bat _parseArray _getRandomNum _getRandomNum2 _randomColor _getLF& setlocal enabledelayedexpansion& title ����Ա����
%CurS% /crv 0& %setWT% ����Ա����,180& cd data
echo "%image%"
pause
::�ο� http://runjs.cn/code/ydp3it7b
call :init
for /l %%i in () do (%_randomColor%)& call :makeup& call :draw& pause>nul



:draw
cls& echo.& echo.& echo.& echo.
echo                       ------���ձ���& echo                       ------������%year%��%month%��%day%�� %week%
%image% /d
%image% ac/ac_%facialExpressionIndex%.bmp 16 12
echo.& echo.& echo.& echo.
echo  �����������Щ�������������������������������
echo  !goodActivityStr!
echo  �����������੤������������������������������
echo  !badActivityStr!
echo  �����������ة�������������������������������
echo.
echo   ��λ��������!direction[%directionIndex%]!д����BUG ���١�
echo   ����������%drinkStr%
%echox% -n "  Ů���׽�ָ����"& %echox% -f D %girlStarStr%
goto :EOF



:init

set facialExpressionMax=54
set girlMaxStar=5
set direction={����,������,����,���Ϸ�,�Ϸ�,���Ϸ�,����,������}& (%_call% ("direction") %_parseArray%)
set drinkIndex=0& (for /f %%i in (drink.txt) do set /a drinkIndex+=1& set drink[!drinkIndex!]=%%i)& set drinkMax=!drinkIndex!
set activityIndex=0& (for /f "tokens=1,2,3 delims=#" %%i in (activity.txt) do set /a activityIndex+=1& set activity[!activityIndex!]=%%i& set activity[!activityIndex!].good=%%j& set activity[!activityIndex!].bad=%%k)& set activityMax=!activityIndex!
goto :EOF


:makeup
for /f "tokens=1,2,3,4 delims=/ " %%a in ("%date%") do set year=%%a& set month=%%b& set day=%%c& set week=%%d
::###############
(%_call% ("1 54 facialExpressionIndex") %_getRandomNum%)
::###############
(%_call% ("2 4 goodActivityNum") %_getRandomNum%)& (%_call% ("2 4 badActivityNum") %_getRandomNum%)& set /a curActivityNum=goodActivityNum+badActivityNum
(%_call% ("1 %activityMax% %curActivityNum% pickActivityIndexStr") %_getRandomNum2%)
set /a goodKeyWordLine=goodActivityNum+1& set /a badKeyWordLine=badActivityNum+1& set goodActivityStr=��        ��                                !LF!& set badActivityStr=��        ��                                !LF!& set pickActivityIndex=1& set pickGoodActivityIndex=1& set pickBadActivityIndex=1
for %%i in (%pickActivityIndexStr%) do (
    if !pickActivityIndex! LEQ !goodActivityNum! (
        set /a pickGoodActivityIndex+=1& if !pickGoodActivityIndex! EQU !goodKeyWordLine! (set goodActivityStr=!goodActivityStr! ��   ��   �� !activity[%%i]!��!activity[%%i].good!��!LF!) else (set goodActivityStr=!goodActivityStr! ��        �� !activity[%%i]!��!activity[%%i].good!��!LF!)
        set /a pickGoodActivityIndex+=1& if !pickGoodActivityIndex! EQU !goodKeyWordLine! (set goodActivityStr=!goodActivityStr! ��   ��   ��                                 !LF!) else (set goodActivityStr=!goodActivityStr! ��        ��                                  !LF!)
    ) else (
        set /a pickBadActivityIndex+=1& if !pickBadActivityIndex! EQU !badKeyWordLine! (set badActivityStr=!badActivityStr! ��  ����  �� !activity[%%i]!��!activity[%%i].bad!��!LF!) else (set badActivityStr=!badActivityStr! ��        �� !activity[%%i]!��!activity[%%i].bad!��!LF!)
        set /a pickBadActivityIndex+=1& if !pickBadActivityIndex! EQU !badKeyWordLine! (set badActivityStr=!badActivityStr! ��  ����  ��                                 !LF!) else (set badActivityStr=!badActivityStr! ��        ��                                  !LF!)
    )
    set /a pickActivityIndex+=1
)
set goodActivityStr=!goodActivityStr:~0,-1!& set badActivityStr=!badActivityStr:~0,-1!
::###############
(%_call% ("0 %direction.maxIndex% directionIndex") %_getRandomNum%)
::###############
(%_call% ("1 %drinkMax% 2 pickDrinkMaxIndexStr") %_getRandomNum2%)
set drinkStr=& (for %%i in (%pickDrinkMaxIndexStr%) do set drinkStr=!drinkStr!��!drink[%%i]!)& set drinkStr=!drinkStr:~1!
::###############
(%_call% ("0 %girlMaxStar% girlLikeStar") %_getRandomNum%)
set /a girlUnLikeStar=girlMaxStar-girlLikeStar& set girlStarStr=& (for /l %%i in (!girlLikeStar!, -1, 1) do set girlStarStr=!girlStarStr!��)& (for /l %%i in (!girlUnLikeStar!, -1, 1) do set girlStarStr=!girlStarStr!��)
goto :EOF