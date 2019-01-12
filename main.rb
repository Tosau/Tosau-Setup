#!/usr/bin/env ruby

def EFI_install
  system "clear"

  puts "UEFI with GPT"
  puts "Mount point	    Partition	Partition type (GUID)	  Suggested size"
  puts "/boot or /efi	  /dev/sdX1	EFI system partition	  260–512 MiB"
  puts "/         	    /dev/sdX2	Linux	                  Remainder of the device"
  puts "[SWAP]	        /dev/sdX3	Linux swap	            More than 512 MiB"

  gets
  exec ("cfdisk; clear; fdisk -l; ruby toscana.rb --efi")
end

def BIOS_install
  puts "BIOS with MBR or GPT"
  puts "Mount point 	Partition 	Partition type  	  Suggested size"
  puts "None	        /dev/sdX1	  BIOS boot partition	1 MiB"
  puts "/	            /dev/sdX2	  Linux	              Remainder of the device"
  puts "[SWAP]	      /dev/sdX3	  Linux swap	        More than 512 MiB"
end

puts "Initializing setup scripts"
puts "You\'ve done it! Congratulations"
puts "Now it\'s our problem if something isn\'t working"
puts "Make yourself some coffee, we\'ll be done soon enough (I hope)"
puts "If you need more information how to use Tosau, check our wiki!"

system "timedatectl set-ntp true"

if system "ping -c 5 google.com"
  puts "Your device is conected to the internet congrats!"
else
  puts "You maybe need to check your internet cable, also you cant use wifi you know"

  exit
end

if system "ls /sys/firmware/efi/efivars"
  puts "System runs in EFI mode, do you want to use it? [yes or nyae?]:"
  if ["yes", "y"].include? gets.downcase.chomp
    EFI_install
  else
    puts "Do you want to use BIOS mode then? [yes or nyae?]:"
    if ["yes", "y"].include? gets.downcase.chomp
      BIOS_install
    else
      exit
    end
  end
else
  puts "System runs in BIOS mode, do you want to use it? [yes or nyae?]:"
  if ["yes", "y"].include? gets.downcase.chomp
    BIOS_install
  else
    exit
  end
end
