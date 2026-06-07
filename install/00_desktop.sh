#!/usr/bin/env bash
PROJ="4cachy"

YS="paru -S --needed --skipreview"

G1="https://github.com/vinceliuice/Tela-circle-icon-theme"
G2="https://github.com/NvChad/starter"

WALL="$HOME/$PROJ/walls/magician-walks-magical-tree-houses-illustration.jpg"

ERRMSG=">>>> ERROR: invalid response! (try y or n)"

clear; cd "$HOME"; echo -e "\n===> WELCOME TO THE POST-INSTALL SCRIPT\n"

#############################################################################
echo -e "\n>>>> FIXING SOME HARDWARE KEYBOARD KEYS...\n"
sudo mkdir -pv /etc/keyd; echo
cat <<EOF | sudo tee /etc/keyd/default.conf
[ids]
*

[main]
f8       = a
f9       = q
grave    = tab
capslock = esc

[shift]
grave    = ~
capslock = capslock

f1 = mute
f2 = volumedown
f3 = volumeup

f4 = brightnessdown
f5 = brightnessup
EOF
##############################################################################
echo -e "\n>>>> CONFIGURING SDDM...\n"
sudo rm -rf /etc/sddm.conf; echo
sudo mkdir -pv /etc/sddm.conf.d; echo
cat <<EOF | sudo tee /etc/sddm.conf.d/meme-sddm.conf
[General]
DisplayServer=wayland
Numlock=on

[Theme]
Current=pixie
EOF
#############################################################################
echo -e "\n>>>> GIVING SYSTEMD-FILES DROP-INS...\n"
sudo mkdir -p /etc/systemd/logind.conf.d /etc/systemd/sleep.conf.d
cat <<EOF | sudo tee /etc/systemd/logind.conf.d/meme-logind.conf
[Login]
HandlePowerKey=suspend-then-hibernate
HandleLidSwitch=suspend-then-hibernate
EOF
cat <<EOF | sudo tee /etc/systemd/sleep.conf.d/meme-sleep.conf
[Sleep]
HibernateDelaySec=1800
EOF
#############################################################################
while true; do
echo -e "\n     SWP CRETION SWP SWPSWPSWPSWPSWPSWPSWPSPWSWPSPWSWPSPWSWPSW\n"

# Check if swap is already active
if swapon --show | grep -q '/swap/swapfile'; then
    echo "Swapfile is already active. Exiting."
    break
fi

# Pure Wiki implementation
sudo btrfs subvolume create /swap
sudo btrfs filesystem mkswapfile --size 16g --uuid clear /swap/swapfile
sudo swapon /swap/swapfile

# Add to fstab if missing
if ! grep -q "/swap/swapfile" /etc/fstab; then
    echo '/swap/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab
fi

echo "Success!"

break
done
###########################################################################
while true; do
  echo -e "\n>>>> RUNNING PACMAN-KEY...\n"

  if sudo pacman-key --init && echo && sudo pacman-key --populate archlinux; then
    clear; echo -e "\n>>>> SUCCESS: completed PACMAN-KEY!\n"; break
  else
    echo -e "\n>>>> ERROR: errors occured in PACMAN-KEY!\n"

    while true; do
      read -p "===> RETRY: retry PACMAN-KEY? (y/n) = " kas
      echo; kas="${kas,,}"

      if [[ "$kas" == "y" ]]; then
        clear; break
      elif [[ "$kas" == "n" ]]; then
        clear; echo -e "\n>>>> ABORT: cancelled PACMAN-KEY!\n"; break 2
      else
        clear; echo -e "\n$ERRMSG\n"
      fi
    done
  fi
done

while true; do
  C1="https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst"
  C2="https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst"

  echo -e "\n>>>> ADDING CHAOTIC-AUR STUFF...\n"

  if
    sudo pacman -U --needed --noconfirm "$C1" && echo &&\
    sudo pacman -U --needed --noconfirm "$C2" && echo; then

     clear; echo -e "\n>>>> SUCCESS: configured CHAOTIC-AUR!\n"; break
  else
    echo -e "\n>>>> ERROR: failed to configure CHAOTIC-AUR!\n"

    while true; do
      read -p "===> RETRY: retry configuring CHAOTIC-AUR? (y/n) = " chos
      echo; chos="${chos,,}"

      if [[ "$chos" == "y" ]]; then
        clear; break
      elif [[ "$chos" == "n" ]]; then
        clear; echo -e "\n>>>> ABORT: cancelled CHAOTIC-AUR setup!\n"; break 2
      else
        clear; echo -e "\n$ERRMSG\n"
      fi
    done
  fi
done



echo -e "\n>>>> CREATING PACMAN DROP-INS (ZERO TOUCH METHOD)...\n"
# 1. Create the directory (it usually doesn't exist by default)
sudo mkdir -p /etc/pacman.d/hooks
# 2. Create your custom settings file
cat <<EOF | sudo tee /etc/pacman.d/meme-custom.conf
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
# 3. Only ONE change to the main file: tell it to look at your new folder
grep -qxF 'Include = /etc/pacman.d/*.conf' /etc/pacman.conf ||\
  echo 'Include = /etc/pacman.d/*.conf'| sudo tee -a /etc/pacman.conf
# 4. OPTIONAL KDEcache FIX HOOK
cat <<EOF | sudo tee /etc/pacman.d/hooks/updateKDEcache.hook
[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Path
Target = usr/share/applications/*.desktop

[Action]
Description = Updating the Kservice desktop file configuration cache...
When = PostTransaction
Exec = /bin/bash -c "sudo -u \"$(logname)\" bash -lc 'XDG_MENU_PREFIX=arch- /usr/bin/kbuildsycoca6 --noincremental'"
Depends = sudo
Depends = coreutils
Depends = kservice
Depends = archlinux-xdg-menu
EOF

while true; do
  clear; echo -e "\n>>>> TESTING PACMAN-UPDATE...\n"

  if sudo pacman -Syu --needed; then
    clear; echo -e "\n>>>> SUCCESS: PACMAN is now fully functional!\n"
    break
  else
    echo -e "\n>>>> ERROR: PACMAN failed!\n"
   
    while true; do
      read -p "===> RETRY: retry running PACMAN? (y/n) = " paca
      echo; paca="${paca,,}"

      if [[ "$paca" == "y" ]]; then
        clear; break
      elif [[ "$paca" == "n" ]]; then
        clear; echo -e "\n>>>> ABORT: cancelled PACMAN-UPDATE!\n"; break 2
      else
        clear; echo -e "\n$ERRMSG\n"
      fi
    done
  fi
done
#############################################################################

cp -r "$HOME/.config" "$HOME/ZBCAKIPZZSSBCKPSNCPSSSZZZZZZZZZ"

while true; do
  read -p "===> CONFIGURE LOCAL DOTFILES? (y/n) = " local
  echo; local="${local,,}"

  if [[ "$local" == "y" ]]; then
    while true; do

      clear; echo -e "\n>>>> configuring DOTFILES...\n"

      if rm -rf "$HOME/.cache/TELA-GIT" "$HOME/.config/nvim"\
        "$HOME/.local/state/nvim" "$HOME/.local/share/nvim" &&\

        echo && git clone "$G1" "$HOME/.cache/TELA-GIT" &&\
        echo && git clone "$G2" "$HOME/.config/nvim" &&\
        echo &&\
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tomasklaen/uosc/HEAD/installers/unix.sh)" &&\
        echo &&\

        echo && cp -rf "$HOME/$PROJ/config/." "$HOME/.config" &&\
        echo && mv -f "$HOME/.config/.gitconfig" "$HOME" &&\

        echo && mkdir -p "$HOME/.local/share/fonts" &&\
        echo && cp -rf "$HOME/$PROJ/misc/flex" "$HOME/.local/share/fonts"; then

        clear; echo -e "\n>>>> SUCCESS: configured DOTFILES!\n"; break 2
      else
        echo -e "\n>>>> ERROR: error while configuring DOTFILES!\n"

        while true; do

          read -p "===> RETRY: retry DOTFILE setup? (y/n) = " das
          echo; das="${das,,}"

          if [[ "$das" == "y" ]]; then
            break
          elif [[ "$das" == "n" ]]; then
            clear; echo -e ">>>> ABORT: cancelled DOTFILES setup!\n\n"; break 3
          else
            clear; echo -e "\n$ERRMSG\n"
          fi
        done
      fi
    done
  elif [[ "$local" == "n" ]]; then
    clear; echo -e "\n>>>> SKIP: skipped DOTFILES setup\n"; break
  else
    clear; echo -e "\n$ERRMSG\n"
  fi
done

while true; do
  read -p "===> INSTALL APPS & OTHER UTILITIES? (y/n) = " apps
  echo; apps="${apps,,}"

  if [[ "$apps" == "y" ]]; then

    while true; do
      
      if clear && echo -e "\n>>>> INSTALLING INTERNAL DEPENDENCIES...\n" &&\
        $YS keyd bibata-cursor-theme-bin adw-gtk-theme lua-language-server\
            gst-plugins-bad xdg-user-dirs archlinux-xdg-menu &&\

        echo -e "\n>>>> INSTALLING FONTS...\n" &&\
        $YS noto-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji\
            ttf-jetbrains-mono-nerd &&\

        echo -e "\n>>>> INSTALLING HYPRLAND AND ITS DEPENDENCIES...\n" &&\
        $YS hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-kde\
            grimblast qt5-wayland hypridle hyprlock hyprpicker hyprpolkitagent\
            hyprpaper &&\

        echo -e "\n>>>> INSTALLING GUI APPLICATIONS...\n" &&\
        $YS sddm brave-bin pavucontrol-qt gwenview rofi-wayland papers\
            nwg-look blueman qbittorrent swaync neovide kcalc grsync\
            waybar network-manager-applet dolphin swappy systemsettings\
            kdialog zen-browser-bin strawberry mpv mpv-mpris &&\

        echo -e "\n>>>> INSTALLING CLI APPLICATIONS...\n" &&\
        $YS fzf lsd bat pacseek-bin fastfetch btop udiskie kitty yazi starship\
            git-credential-manager-bin wl-clipboard brightnessctl alsa-utils\
            power-profiles-daemon matugen &&\

        echo -e "\n>>>> INSTALLING VULKAN & STUFF...\n" &&\
        $YS lib32-vulkan-intel vulkan-tools intel-media-driver\
            intel-gpu-tools &&\

        echo -e "\n>>>> INSTALLING AUR PACKAGES...\n" &&\
        $YS wvkbd ayugram-desktop darkly-bin\
            pixie-sddm-git clipse-wayland-bin emojify-bin\
            libadwaita-without-adwaita-git; then

        clear; echo -e "\n>>>> SUCCESS: finished installing APPS & UTILS!\n"
        break 2
      else
        echo -e "\n>>>> ERROR: failed installing some APPS!\n"

        while true; do

          read -p "===> RETRY: retry installing APPS & UTILS? (y/n) = " rias
          echo; rias="${rias,,}"

          if [[ "$rias" == "y" ]]; then
            break
          elif [[ "$rias" == "n" ]]; then
            clear; echo -e "\n>>>> ABORT: aborted APPS & UTILS installation!\n"
            break 3
          else
            clear; echo -e "\n$ERRMSG\n"
          fi
        done
      fi
    done
  elif [[ "$apps" == "n" ]]; then
    clear; echo -e "\n>>>> SKIP: skipped installing APPS & UTILS\n"; break
  else
    clear; echo -e "\n$ERRMSG\n"
  fi
done

echo -e "\n>>>> CREATING XDG DIRECTORIES...\n"
xdg-user-dirs-update; mkdir -p "$HOME/Pictures/Screenshots"

echo -e "\n>>>> ENABLING SERVICES...\n"
sudo systemctl enable power-profiles-daemon sddm keyd

echo "$WALL" > "$HOME/.cache/last_wall.txt"

while true; do
  read -p "===> SCRIPT ENDED, REBOOT NOW? (y/n) = " nas; echo
  nas="${nas,,}"

  if [[ "$nas" == "y" ]]; then
    clear; echo -e "\n>>>> REBOOT INITIATED...\n"
    sleep 3; sync; sync; sync; systemctl reboot
  elif [[ "$nas" == "n" ]]; then
    clear; echo -e "\n>>>> OKAY, REBOOT MANUALLY!\n"; exit
  else
    clear; echo -e "\n$ERRMSG\n"
  fi
done
