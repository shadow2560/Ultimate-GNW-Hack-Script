echo ""> ./run_again.txt
pacman -Syuu --noconfirm
pacman -S mingw-w64-x86_64-python mingw-w64-x86_64-python-pip mingw-w64-x86_64-python-setuptools mingw-w64-x86_64-python-wheel mingw-w64-x86_64-python-lz4 mingw-w64-x86_64-python-pillow mingw-w64-x86_64-python-tqdm mingw-w64-x86_64-python-yaml mingw-w64-x86_64-python-pyzopfli mingw-w64-x86_64-python-pyelftools mingw-w64-x86_64-python-pycryptodome mingw-w64-x86_64-python-keystone mingw-w64-x86_64-python-colorama mingw-w64-x86_64-python-numpy mingw-w64-x86_64-python-psutil --noconfirm --needed
pacman -S mingw-w64-x86_64-arm-none-eabi-toolchain --noconfirm --needed
pacman -S mingw-w64-x86_64-gcc --noconfirm --needed
pacman -S make --noconfirm --needed
pacman -S git --noconfirm --needed
pacman -S mingw-w64-x86_64-openocd --noconfirm --needed
pacman -S mingw-w64-x86_64-SDL2 --noconfirm --needed
pacman -S wget unzip --noconfirm --needed

# pacman -S mingw-w64-x86_64-rust cmake mingw-w64-x86_64-python-capstone mingw-w64-x86_64-cargo-c mingw-w64-x86_64-cmake mingw-w64-x86_64-emacs mingw-w64-x86_64-make

SETUPTOOLS_USE_DISTUTILS=stdlib
# pip install --break-system-packages --upgrade gnwmanager

# pip install cmsis-pack-manager
# SETUPTOOLS_USE_DISTUTILS=stdlib CMAKE_C_COMPILER=gcc CMAKE_CXX_COMPILER=g++ CMAKE_EXE_LINKER_FLAGS="-Wl,--allow-multiple-definition" pip install --use-pep517 pyocd
# gnwmanager install openocd
# SETUPTOOLS_USE_DISTUTILS=stdlib pip install --upgrade gnwmanager --no-binary :all:

# rm -r -f ../arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi
# wget "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip?rev=93fda279901c4c0299e03e5c4899b51f&hash=99EF910A1409E119125AF8FED325CF79" -O gcc-arm-none-eabi-13.2.zip
# unzip -o gcc-arm-none-eabi-13.2.zip -d ../
# rm gcc-arm-none-eabi-13.2.zip

rm -r -f ./python
wget https://aka.ms/nugetclidl -O nuget.exe
./nuget.exe install python -version 3.12.3 -ExcludeVersion -OutputDirectory .
./python/tools/python.exe -m pip install --break-system-packages --no-warn-script-location pyocd gnwmanager
cp ./resources/libusb-1.0.dll ./python/tools/libusb-1.0.dll
cp ./resources/libusb-1.0.dll ./python/tools/Scripts/libusb-1.0.dll

rm -r -f ../gcc-arm-none-eabi-10.3-2021.10
wget "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-win32.zip?rev=8f4a92e2ec2040f89912f372a55d8cf3&hash=5569B4C322E49BB400BFB63567A4B33B" -O gcc-arm-none-eabi-10.3-2021.10-win32.zip
# wget "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-win32.zip" -o gcc-arm-none-eabi-10.3-2021.10-win32.zip
unzip -o gcc-arm-none-eabi-10.3-2021.10-win32.zip -d ../
rm gcc-arm-none-eabi-10.3-2021.10-win32.zip

rm /mingw64/bin/openocd.exe
cp ./resources/openocd/openocd.exe /mingw64/bin/openocd.exe
rm ./run_again.txt