@echo off
setlocal

echo Trying to build with MSYS2/Mingw-w64 (with -lmswsock)...
g++ -std=c++17 src\main.cpp -Iinclude -Icrow\include -lpthread -lws2_32 -lmswsock -o server.exe
if errorlevel 1 (
    echo Failed MSYS2/Mingw-w64 build. Trying build without -lmswsock (older MinGW)...
    g++ -std=c++17 src\main.cpp -Iinclude -Icrow\include -lpthread -lws2_32 -o server.exe
    if errorlevel 1 (
        echo Failed older MinGW build. Trying build with MSVC (using cl)...
        cl /EHsc /Iinclude /Icrow\include src\main.cpp /Fe:server.exe
        if errorlevel 1 (
            echo Failed MSVC build.
            pause
            exit /b 1
        )
    )
)

echo Build succeeded!
echo Running server...
server.exe

pause
endlocal
