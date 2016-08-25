#!/system/bin/sh


# Mount System partition writable
echo "***		Mounting System partition writable..."
su -c 'mount -o remount,rw /dev/block/platform/msm_sdcc.1/by-name/system /system'

# Check if Swapfile exists
# If not exist: Initialize a Swapfile
if [ ! -e /system/Swapfile ]; 
	then
		echo "***	Swapfile is not exist. Try to create one."
		
		# Create an empty raw image
		# Size can be specified. Just follow the following formula:
			# Size in megabyte = count / bs
			# 'bs' (sector size) constantly equals 1024.
		echo "		***	Creating..."
		su -c 'dd if=/dev/zero of=/system/Swapfile bs=1024 count=262144'
		
		echo "		***	Initializing..."
		su -c 'mkswap /system/Swapfile'
fi

# Turn on swap
echo "***		Turning on Swap..."
su -c 'swapon -p 999 /system/Swapfile'


