echo ""> ./run_again.txt
pacman -Syuu --noconfirm
pacman -S mingw-w64-x86_64-python mingw-w64-x86_64-python-pip mingw-w64-x86_64-python-lz4 mingw-w64-x86_64-python-pillow mingw-w64-x86_64-python-tqdm mingw-w64-x86_64-python-yaml mingw-w64-x86_64-python-pyzopfli mingw-w64-x86_64-python-pyelftools mingw-w64-x86_64-python-pycryptodome mingw-w64-x86_64-python-keystone mingw-w64-x86_64-python-colorama mingw-w64-x86_64-python-numpy mingw-w64-x86_64-python-psutil --noconfirm
pacman -S mingw-w64-x86_64-arm-none-eabi-toolchain --noconfirm
pacman -S mingw-w64-x86_64-gcc --noconfirm
pacman -S make --noconfirm
pacman -S git --noconfirm
# pacman -S mingw-w64-x86_64-openocd --noconfirm
pacman -S mingw-w64-x86_64-SDL2 --noconfirm
pacman -S wget unzip --noconfirm

# pacman -S mingw-w64-x86_64-rust mingw-w64-x86_64-nmake mingw-w64-x86_64-python-capstone

SETUPTOOLS_USE_DISTUTILS=stdlib pip install --upgrade gnwmanager
gnwmanager install openocd
# SETUPTOOLS_USE_DISTUTILS=stdlib pip install --upgrade gnwmanager --no-binary :all:

rm -r -f ../gcc-arm-none-eabi-10.3-2021.10
wget "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-win32.zip?rev=8f4a92e2ec2040f89912f372a55d8cf3&hash=5569B4C322E49BB400BFB63567A4B33B" -O gcc-arm-none-eabi-10.3-2021.10-win32.zip
# wget "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-win32.zip" -o gcc-arm-none-eabi-10.3-2021.10-win32.zip
unzip -o gcc-arm-none-eabi-10.3-2021.10-win32.zip -d ../
rm gcc-arm-none-eabi-10.3-2021.10-win32.zip

# rm /mingw64/bin/openocd.exe
# cp ./resources/openocd.exe /mingw64/bin/openocd.exe
rm ./run_again.txt