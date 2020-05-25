# Adapted from work found here: http://ramblingcookiemonster.github.io/Building-A-PowerShell-Module/

#module specific
$ModuleName = '{ModuleName}'
$Description = '{Description}'
$Tags = @('Atlassian')

# common values
$Path = "D:\GitHub\$ModuleName"
$Author = 'Justin Mead'
$Company = 'ender2021'
$uriRoot = "https://github.com/ender2021/"
$ProjectUri = "$uriRoot$ModuleName"
$LicenseUri = "$uriRoot$ModuleName/blob/master/LICENSE.md"

# Create the module and private function directories
mkdir $Path\$ModuleName
mkdir $Path\$ModuleName\classes
mkdir $Path\$ModuleName\private
mkdir $Path\$ModuleName\public
mkdir $Path\$ModuleName\en-US # For about_Help files
mkdir $Path\tests

#Copy and name the module files
Copy-Item -Path "$PSScriptRoot\files\Module.psm1" -Destination "$Path\$ModuleName\$ModuleName.psm1"
Copy-Item -Path "$PSScriptRoot\files\Module.Format.Ps1xml" -Destination "$Path\$ModuleName\$ModuleName.Format.ps1xml"
Copy-Item -Path "$PSScriptRoot\files\appveyor.yml" -Destination "$Path\appveyor.yml"
Copy-Item -Path "$PSScriptRoot\files\build.ps1" -Destination "$Path\build.ps1"
Copy-Item -Path "$PSScriptRoot\files\deploy.psdeploy.ps1" -Destination "$Path\deploy.psdeploy.ps1"
Copy-Item -Path "$PSScriptRoot\files\psake.ps1" -Destination "$Path\psake.ps1"

#create new blank files
New-Item "$Path\$ModuleName\en-US\about_$ModuleName.help.txt" -ItemType File
New-Item "$Path\Tests\$ModuleName.Tests.ps1" -ItemType File

#create the manifest
New-ModuleManifest -Path $Path\$ModuleName\$ModuleName.psd1 `
                   -RootModule $ModuleName.psm1 `
                   -Description $Description `
                   -PowerShellVersion 6.1 `
                   -Author $Author `
                   -CompanyName $Company `
                   -FunctionsToExport '*' `
                   -AliasesToExport '*' `
                   -ProjectUri $ProjectUri `
                   -LicenseUri $LicenseUri `
                   -Tags $Tags `
                   -FormatsToProcess "$ModuleName.Format.ps1xml"