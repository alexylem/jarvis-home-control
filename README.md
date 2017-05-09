<!---
IMPORTANT
=========
This README.md is displayed in the WebStore as well as within Jarvis app
Please do not change the structure of this file
Fill-in Description, Usage & Author sections
Make sure to rename the [en] folder into the language code your plugin is written in (ex: fr, es, de, it...)
For multi-language plugin:
- clone the language directory and translate commands/functions.sh
- optionally write the Description / Usage sections in several languages
-->
## Description
If your home automation system can be controlled via http requests, this Jarvis plugin is just for you.
It will allow you to simply turn on and off your devices.

## Configuration

1. Indicate the turn on and turn off http urls (with `[ADDRESS]` placeholder):
   
   ```
   pg_hc_turnon_url="http://192.168.1.1/home.php?action=on&device=[ADDRESS]"
   pg_hc_turnoff_url="http://192.168.1.1/home.php?action=off&device=[ADDRESS]"
   ```
   
2. List your device names & corresponding addresses in `json` format
   
   ```
   pg_hc_config='{ "devices":[
       { "name": "BEDROOM", "address": "A1"},
       { "name": "LIVING ROOM", "address": "A2"},
       { "name": "BAR", "address": "A3"}
   ]}'
   ```

## Usage

**Français**
```
Vous: allume le bar
# > http://192.168.1.1/home.php?action=on&device=A3
Jarvis: j'allume le bar
```

**English**
```
You: switch on the bar
# > http://192.168.1.1/home.php?action=on&device=A3
Jarvis: turning on the bar
```

## Author
[alexylem](https://github.com/alexylem)
