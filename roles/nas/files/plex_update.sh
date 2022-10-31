#!/usr/bin/env bash

mkdir /volume1/tmp/plex >/dev/null 2>&1
rm -rf /volume1/tmp/plex/*.spk

token=$(grep -oP 'PlexOnlineToken="\K[^"]+' /volume1/Plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml)

jq=$(curl -s url="https://plex.tv/api/downloads/5.json?channel=plexpass&X-Plex-Token=$token")

newversion=$(echo "$jq" | jq -r '.nas["Synology (DSM 7)"].version')
curversion=$(synopkg version "PlexMediaServer")

if [ "$newversion" != "$curversion" ]; then
  echo "New Version Available: $curversion => $newversion"
  /usr/syno/bin/synonotify PKGHasUpgrade "{\"[%HOSTNAME%]\": $(hostname), \"[%OSNAME%]\": \"Synology\", \"[%PKG_HAS_UPDATE%]\": \"Plex\", \"[%COMPANY_NAME%]\": \"Synology\"}"
  cpu=$(uname -m)
  if [ "$cpu" = "x86_64" ]; then
    url=$(echo "$jq" | jq -r '.nas["Synology (DSM 7)"].releases[1] | .url')
  else
    url=$(echo "$jq" | jq -r '.nas["Synology (DSM 7)"].releases[0] | .url')
  fi

  echo "Downloading new version of Plex url=$url"
  /bin/wget "$url" -P /volume1/tmp/plex/

  echo "Installing new version"
  /usr/syno/bin/synopkg install /volume1/tmp/plex/*.spk

  sleep 30
  echo "Restarting Plex Media Server"
  /usr/syno/bin/synopkg start "PlexMediaServer"
  rm -rf /volume1/tmp/plex/*

else
  echo "No New Version. version=$curversion"
fi

exit
