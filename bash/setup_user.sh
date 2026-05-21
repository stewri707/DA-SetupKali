#!/usr/bin/env bash

ScriptDir=setup_user_scripts
$ScriptDir/venv_dir.sh
$ScriptDir/certipy.sh
$ScriptDir/road.sh
$ScriptDir/tools.sh
$ScriptDir/pywhisker.sh
$ScriptDir/pkinittools.sh
$ScriptDir/modifyCertTemplate.sh
$ScriptDir/bloodyAD.sh
$ScriptDir/donpapi.sh # errors out
$ScriptDir/gmsadumper.sh
$ScriptDir/gpoddity.sh
$ScriptDir/impacket-latest.sh
$ScriptDir/krbrelayx.sh
$ScriptDir/webclientServiceScanner.sh
$ScriptDir/bloodhoundpy.sh
$ScriptDir/powerview.sh
$ScriptDir/pypykatz.sh
$ScriptDir/passthecert.sh
$ScriptDir/ldaprelayscan.sh # errors out

# Setup fzf last as it modifies the shell configuration files
FzfSetupDir=setup_fzf
$ScriptDir/$FzfSetupDir/fzf.sh
