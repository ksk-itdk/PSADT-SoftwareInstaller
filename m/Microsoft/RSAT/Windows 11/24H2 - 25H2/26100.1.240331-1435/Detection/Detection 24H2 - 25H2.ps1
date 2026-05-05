$ErrorActionPreference = 'Stop'

$required = @(
    'Rsat.ActiveDirectory.DS-LDS.Tools*',
    'Rsat.AzureStack.HCI.Management.Tools*',
    'Rsat.BitLocker.Recovery.Tools*',
    'Rsat.CertificateServices.Tools*',
    'Rsat.DHCP.Tools*',
    'Rsat.Dns.Tools*',
    'Rsat.FileServices.Tools*',
    'Rsat.GroupPolicy.Management.Tools*',
    'Rsat.IPAM.Client.Tools*',
    'Rsat.LLDP.Tools*',
    'Rsat.NetworkController.Tools*',
    'Rsat.NetworkLoadBalancing.Tools*',
    'Rsat.RemoteAccess.Management.Tools*',
    'Rsat.RemoteDesktop.Services.Tools*',
    'Rsat.ServerManager.Tools*',
    'Rsat.StorageReplica.Tools*',
    'Rsat.VolumeActivation.Tools*',
    'Rsat.WSUS.Tools*'
)

try {
	$missingRequired = foreach ($r in $required) {
		Get-WindowsCapability -Online -Name $r | Where-Object State -ne 'Installed'
	}
	if ($missingRequired) {
		Write-Output "Not detected: Missing required RSAT components"
		exit 1
	} else {
		Write-Output "Detected: Required RSAT components installed"
		exit 0
	}
}
catch {
	Write-Output "Not detected: RSAT detection script error: $($_.Exception.Message)"
    exit 1
}