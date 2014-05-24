STM32CubeMx GNU toolchain
=========================
##Prerequisite
- [openocd](http://sourceforge.net/projects/openocd/)
- [st-link](https://github.com/texane/stlink)
```
sudo apt-get install automake* libtool libusb-1.0-0-dev
git clone http://github.com/texane/stlink.git
cd stlink
./autogen.sh
./configure --prefix=/usr
make
sudo make install
sudo cp 49-stlinkv2.rules /etc/udev/rules.d/
```
- [GNU Tools for ARM Embedded Processors](https://launchpad.net/~terry.guo/+archive/gcc-arm-embedded)

```
sudo add-apt-repository ppa:terry.guo/gcc-arm-embedded
sudo apt-get update
sudo apt-get install gcc-arm-none-eabi
```
##How to use 

- Just edit your source code (.c) in `./firmware/Src` and header files (.h) in `/firmware/Inc`. 
- Type the command in your terminal:
`make && make flash`

