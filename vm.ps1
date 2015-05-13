# vmp.ps1 - Operating a virtual machine with VMware VIX
# This script runs only on PowerShell or the compatible system.

Param($action, $name)

$vmwareVIXRootDirectory = "C:\Program Files (x86)\VMware\VMware VIX";
$rootVirtualMachineDirectory = "C:\Users\Saneyuki\Virtual Machines\VMWare";
$runType = "workstation";
$vmctl = "& '$vmwareVIXRootDirectory\vmrun.exe'"

function Start-VirtualMachine($name) {
	echo "Starting a virtual machine..."
	Invoke-Expression -command ("$vmctl -T $runType start " + (Get-VMXPath $name))
	echo "Started"
}

function Stop-VirtualMachine($name) {
	echo "Stopping a virtual machine..."
	Invoke-Expression -command ("$vmctl -T $runType stop " + (Get-VMXPath $name))
	echo "Stopped"
} 

function Suspend-VirtualMachine($name) {
	echo "Suspending a virtual machine..."
	Invoke-Expression -command ("$vmctl -T $runType suspend " + (Get-VMXPath $name))
	echo "Suspended"
}

function Restart-VirtualMachine($name) {
	echo "Restarting:"
	Stop-VirtualMachine $name
	Start-VirtualMachine $name
}

function Get-VMXPath($name) {
	return '$rootVirtualMachineDirectory\$name\$name.vmx'
}

switch ($action) {
	"start" { Start-VirtualMachine $name }
	"stop" { Stop-VirtualMachine $name }
	"restart" { Restart-VirtualMachine $name }
	"suspend" { Suspend-VirtualMachine $name }
	default { echo "start|stop|restart <virtual_machine_name>" }
}
