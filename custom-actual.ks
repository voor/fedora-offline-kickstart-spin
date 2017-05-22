# This is my custom kickstart.

lang en_US.UTF-8
keyboard us

timezone US/Eastern

auth --useshadow --passalgo=sha512
selinux --enforcing
rootpw --lock --iscrypted ThisBreaksThePasswordLulz
user --name=none
user --name=gateway --uid=5000 --gid=5000

firewall --enable --service=http,https,dns,ssh

bootloader --location=mbr --boot-drive=sda

network --bootproto=dhcp --device=link --activate --onboot=on
services --enabled=NetworkManager,chronyd,sshd

zerombr
clearpart --all --initlabel --drives=sda

poweroff
text

part /boot --fstype="ext4" --ondisk=sda --size=300
part pv.316 --fstype="lvmpv" --ondisk=sda --size=5983 --grow
part /boot/efi --fstype="efi" --ondisk=sda --size=200 --fsoptions="umask=0077,shortname=winnt"
volgroup gateway --pesize=4096 pv.316
logvol /var  --fstype="ext4" --grow --size=500 --name=var --vgname=gateway
logvol /  --fstype="ext4" --grow --size=1024 --name=root --vgname=gateway
logvol swap  --fstype="swap" --size=3514 --name=swap --vgname=gateway

# Additional packages
# repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-25&arch=x86_64
# repo --name=additional --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f25&arch=x86_64

cdrom

%include custom-packages.ks

%packages
@^minimal-environment

# Explicitly specified here:
# <notting> walters: because otherwise dependency loops cause yum issues.
kernel
grub2
chrony

%end

%post

# Set the Root SSH Keys.
install -d -m0700 /root/.ssh/

cat <<EOF >/root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4b37heVuc0s+fkkXC6xJI+Fx7haGvu9GgaqHMMYtcggxpPvKz9jWjmZCv7UusgTWSkwdD2E0LF97w8jB2QDtKOz25QqXHLCtCAQPIt5Aq84Jz8hTKUg/mXTizQG6Ryh+SBgWnhLwxaO5k89DkS3V+iVl6+Lu0tchIaqiN44GEEGdBAiYOyjgcH2HEJrm4uuO8DsOFOHJEP0NTc6AMOsD/AJO13bwVQc6NjJa/FfmYlxutFjycG/TKw6Op/dP3NuElBJElcr54BPseqXcGwb0j0Taf9wS4Vk61Jhnq9KRt4/kcY97RSHa42upBftvusLJ1QBqtR4wrNyErG7g4C7uoq3cnqML01I5LIRAcYwpooiCVWpYyVKWzi9GMHdK4XaFDjOW4a1d8xyOBFcVn5KsSdM06FtedXP0VswubyuKNLLOv5Jo0p02zNpfNBcqIuVoJ6CPtvKDxfoehgp0t0Uatxgx49n8OKmEhsRwfqrvVqyOJJu+D1Tnq1tm6eScTkwc+m/scSe+DfcZt00uMdNMXgeQ6WWOH33+SYGIQ22TP+krYxxWg71j39BR7Gf67w0lDtdRSuhq+fgPmmzvvsiyVZYi27RZgydV1KbTLmP35mh3X8/zTt8m+JBNZqA9cWWhZFRvKkX6irKFfqGbLp7qrnoMu67OJtPgH0cD/yAf9IQ== rcvanvo@gmail.com
EOF

chmod 0600 /root/.ssh/authorized_keys

# Selinux
restorecon -R /root/.ssh/

%end

%post --nochroot

%end
