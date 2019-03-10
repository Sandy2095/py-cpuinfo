#!/bin/bash
set -e

echo "Finding OS ..."
OS="unknown"
PYINSTALLER="unknown"
if [[ "$OSTYPE" == "linux"* ]]; then
	OS="linux"
	PYINSTALLER="~/.local/bin/pyinstaller"
elif [ "$OSTYPE" == "msys" ] || [ "$OSTYPE" == "win32" ]; then
	OS="windows"
	PYINSTALLER="pyinstaller"
else
	echo "Unknown OS: $OSTYPE"
	exit
fi

echo "Cleanup ..."
rm -rf -f build
rm -rf -f dist
rm -f *.spec
set +e
py -2 -m pip uninstall PyInstaller -y > /dev/null 2>&1
py -3 -m pip uninstall PyInstaller -y > /dev/null 2>&1
set -e

echo "Running Python 3 main ..."
py -3 test_main.py

echo "Running Python 3 NO main ..."
py -3 test_no_main.py

echo "Running Python 2 main ..."
py -2 test_main.py

echo "Running Python 2 NO main ..."
py -2 test_no_main.py

echo "Running Python 2 PyInstaller NO main ..."
py -2 -m pip install PyInstaller > /dev/null 2>&1
$PYINSTALLER --onefile test_no_main.py > /dev/null 2>&1
cd dist
./test_no_main
cd ..
rm -rf -f build
rm -rf -f dist

echo "Running Python 2 PyInstaller main ..."
$PYINSTALLER --onefile test_main.py > /dev/null 2>&1
cd dist
./test_main
cd ..
rm -rf -f build
rm -rf -f dist
py -2 -m pip uninstall PyInstaller -y > /dev/null 2>&1

echo "Running Python 3 PyInstaller NO main ..."
py -3 -m pip install PyInstaller > /dev/null 2>&1
$PYINSTALLER --onefile test_no_main.py > /dev/null 2>&1
cd dist
./test_no_main
cd ..
rm -rf -f build
rm -rf -f dist

echo "Running Python 3 PyInstaller main ..."
$PYINSTALLER --onefile test_main.py > /dev/null 2>&1
cd dist
./test_main
cd ..
rm -rf -f build
rm -rf -f dist
py -3 -m pip uninstall PyInstaller -y > /dev/null 2>&1

echo "Cleanup ..."
rm -rf -f build
rm -rf -f dist
rm -f *.spec
set +e
py -2 -m pip uninstall PyInstaller -y > /dev/null 2>&1
py -3 -m pip uninstall PyInstaller -y > /dev/null 2>&1
set -e
