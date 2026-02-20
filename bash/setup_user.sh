#!/usr/bin/env bash

ScriptDir=setup_user_scripts
$ScriptDir/venv_dir.sh
$ScriptDir/road.sh
$ScriptDir/tools.sh
$ScriptDir/pywhisker.sh
$ScriptDir/pkinittools
$ScriptDir/modifyCertTemplate.sh
$ScriptDir/bloodyAD.sh
# $ScriptDir/donpapi.sh errors out
$ScriptDir/gmsadumper.sh
$ScriptDir/krbrelayx.sh
$ScriptDir/webclientServiceScanner.sh
$ScriptDir/bloodhoundpy.sh
$ScriptDir/powerview.sh
# $ScriptDir/ldaprelayscan.sh errors out
