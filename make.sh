#!/bin/sh

CURRENT=$(pwd)

if [ -z "$1" ]
then
	echo "Usage: $0 app | web | cfg | custom | fs | all"
	exit;
fi


MKSQUASHFS=$CURRENT/tools/mksquashfs
MKFSJFFS2=$CURRENT/tools/mkfs.jffs2

BOOT_SIZE=192
KERNEL_SIZE=3328
APP_SIZE=2368
WEB_SIZE=1664
CUSTOM_SIZE=192
CONFIG_SIZE=384

BOOT_SIZE_BYTE=`expr $BOOT_SIZE \* 1024 + 64 \* 1024`
KERNEL_SIZE_BYTE=`expr $KERNEL_SIZE \* 1024`
APP_SIZE_BYTE=`expr $APP_SIZE \* 1024`
WEB_SIZE_BYTE=`expr $WEB_SIZE \* 1024`
CUSTOM_SIZE=`expr $CUSTOM_SIZE \* 1024`
CONFIG_SIZE_BYTE=`expr $CONFIG_SIZE \* 1024`

ROOTFS=rootfs_8M.bin
ROOTFS_F=rootfs_8M_F.bin

PartCMP()
{
PartSize=$(du -s $PartName | cut -f1)
if [ $PartSize -gt $PartLimit ];then
	echo "$PartName $PartSize 超过限制 Limte Size:$PartLimit!请退出!"
	#sleep 10;
	#read;
	echo "error!!!"
	rm $1.img
	exit 0;
else
	echo "$PartName $PartSize 小于等于 Limite Size:$PartLimit!继续!"
fi
}

if [ "$1" = "app" ] && [ "$2" != "7101_V1_S" ] && [ "$2" != "7102_V2_S" ] && [ "$2" != "7102_V2_S_100" ] && [ "$2" != "7102_V2_S_130" ] && [ "$2" != "7101_V2_S" ] && [ "$2" != "7101_V2_D" ] && [ "$2" != "mis1002" ]\
&& [ "$2" != "jxh61" ] && [ "$2" != "ar0237" ]
then
	echo "Usage: $0 app 7101_V1_S/7102_V2_S/7102_V2_S_100/7102_V2_S_130/7101_V2_S/7101_V2_D/mis1002/"
	exit 0;
fi

if [ $1 = "app" ]
then
	rm -rf $CURRENT/app/etc/sensors/*
	case "$2" in
		7101_V1_S)
			echo "Add imx322 bin"
			cp $CURRENT/sensors/imx122.bin $CURRENT/app/etc/sensors		
			;;
                7102_V2_S)
                        echo "Add jxh42 sc1045 jxh61 ar0130 sc1035 bin"
                        cp $CURRENT/sensors/jxh42.bin $CURRENT/app/etc/sensors
                        cp $CURRENT/sensors/sc1045.bin $CURRENT/app/etc/sensors
                        cp $CURRENT/sensors/ar0130.bin $CURRENT/app/etc/sensors
                        cp $CURRENT/sensors/jxh61.bin $CURRENT/app/etc/sensors
                        cp $CURRENT/sensors/sc1035.bin $CURRENT/app/etc/sensors
                        ;;
		7102_V2_S_100)
			echo "Add jxh42 sc1045 bin"
			cp $CURRENT/sensors/jxh42.bin $CURRENT/app/etc/sensors
			cp $CURRENT/sensors/sc1045.bin $CURRENT/app/etc/sensors
                        cp $CURRENT/sensors/sc1145.bin $CURRENT/app/etc/sensors
			;;
		7102_V2_S_130)
			echo "Add jxh61 ar0130 sc1035 bin"
			cp $CURRENT/sensors/ar0130.bin $CURRENT/app/etc/sensors
			cp $CURRENT/sensors/jxh61.bin $CURRENT/app/etc/sensors
			cp $CURRENT/sensors/sc1035.bin $CURRENT/app/etc/sensors
			;;			
		7101_V2_S)
			echo "Add ov2710 imx322 sc2035 ar0237 bin"
			cp $CURRENT/sensors/ov2710.bin $CURRENT/app/etc/sensors
			cp $CURRENT/sensors/imx122.bin $CURRENT/app/etc/sensors
			cp $CURRENT/sensors/sc2035.bin $CURRENT/app/etc/sensors				
			cp $CURRENT/sensors/ar0237.bin $CURRENT/app/etc/sensors
			;;
		7101_V2_D)
			echo "Add sc1045 ar0130 bin"
			cp $CURRENT/sensors/sc1045.bin $CURRENT/app/etc/sensors
			cp $CURRENT/sensors/ar0130.bin $CURRENT/app/etc/sensors
			;;
		mis1002)
			echo "Add mis1002 bin"
			cp $CURRENT/sensors/mis1002.bin $CURRENT/app/etc/sensors
			;;			
		ar0237)
			echo "Add ar0237 bin"
			cp $CURRENT/sensors/ar0237.bin $CURRENT/app/etc/sensors
			;;			
	esac
fi


rm $1.img
if [ $1 = "app" ]
then
	$MKSQUASHFS $CURRENT/$1 $1.img -b 128K -comp xz
	PartName=$1.img
	PartLimit=$APP_SIZE
	PartCMP
#	cp $1.img /home/work/temp
	exit;
elif [ $1 = "web" ]
then
	$MKSQUASHFS $CURRENT/$1 $1.img -b 128K -comp xz
	PartName=$1.img
	PartLimit=$WEB_SIZE
	PartCMP
#	cp $1.img /home/work/temp
	exit;
elif [ $1 = "cfg" ]
then
	$MKFSJFFS2 -d $1 -l -e 0x10000 -o $1.img --pad=0x60000
#	cp $1.img /home/work/temp
	exit;
elif [ $1 = "custom" ]
then
	$MKSQUASHFS $CURRENT/$1 $1.img -b 128K -comp xz
	PartName=$1.img
	PartLimit=$CUSTOM_SIZE
	PartCMP
#	cp $1.img /home/work/temp
	exit;
elif [ $1 = "all" ]
then
	rm *.img
	$MKSQUASHFS $CURRENT/app app.img -b 128K -comp xz
	PartName=app.img
	PartLimit=$APP_SIZE
	PartCMP
#	cp app.img /home/work/temp
	
	$MKSQUASHFS $CURRENT/web web.img -b 128K -comp xz
	PartName=web.img
	PartLimit=$WEB_SIZE
	PartCMP
#	cp web.img /home/work/temp
	
	$MKSQUASHFS $CURRENT/custom custom.img -b 128K -comp xz
	PartName=custom.img
	PartLimit=$CUSTOM_SIZE
	PartCMP
#	cp custom.img /home/work/temp
	
	$MKFSJFFS2 -d cfg -l -e 0x10000 -o cfg.img --pad=0x60000
#	cp cfg.img /home/work/temp
	
	rm -vrf combine_file $ROOTFS 
	gcc ./combine_file.c -o combine_file

	echo Start to create $ROOTFS!
	#echo $BOOT_SIZE_BYTE $KERNEL_SIZE_BYTE $APP_SIZE_BYTE $WEB_SIZE_BYTE $CUSTOM_SIZE $CONFIG_SIZE_BYTE
	./combine_file $ROOTFS 	uboot.bin       $BOOT_SIZE_BYTE
	./combine_file $ROOTFS 	zImage          $KERNEL_SIZE_BYTE
	./combine_file $ROOTFS 	app.img      		$APP_SIZE_BYTE
	./combine_file $ROOTFS 	web.img      		$WEB_SIZE_BYTE
	./combine_file $ROOTFS 	custom.img  		$CUSTOM_SIZE
	./combine_file $ROOTFS 	cfg.img    			$CONFIG_SIZE_BYTE
	#./combine_file $ROOTFS 	onvif_fs.jffs2  8388608
	chmod 777 $ROOTFS
	echo create $ROOTFS successful! 
	ls -lh $ROOTFS
#	cp $ROOTFS /home/work/temp
	./solf_to_burn $ROOTFS $ROOTFS_F 
#	cp $ROOTFS_F /home/work/temp
	exit;
elif [ $1 = "fs" ]
then
	rm -vrf combine_file $ROOTFS 
	gcc ./combine_file.c -o combine_file

	echo Start to create $ROOTFS!
	#echo $BOOT_SIZE_BYTE $KERNEL_SIZE_BYTE $APP_SIZE_BYTE $WEB_SIZE_BYTE $CUSTOM_SIZE $CONFIG_SIZE_BYTE
	./combine_file $ROOTFS 	uboot.bin       $BOOT_SIZE_BYTE
	./combine_file $ROOTFS 	zImage          $KERNEL_SIZE_BYTE
	./combine_file $ROOTFS 	app.img      		$APP_SIZE_BYTE
	./combine_file $ROOTFS 	web.img      		$WEB_SIZE_BYTE
	./combine_file $ROOTFS 	custom.img  		$CUSTOM_SIZE
	./combine_file $ROOTFS 	cfg.img    			$CONFIG_SIZE_BYTE
	#./combine_file $ROOTFS 	onvif_fs.jffs2  8388608
	chmod 777 $ROOTFS
	echo create $ROOTFS successful! 
	ls -lh $ROOTFS
	./solf_to_burn $ROOTFS $ROOTFS_F 
	exit;
else
	echo "Usage: $0 app | web | cfg | custom | fs | all "
	exit;
fi

exit 0
