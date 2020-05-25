#import modules
#Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerConfluence\PowerConfluence\PowerConfluence.psm1) -Force
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerConfluenceSqlRefresh\PowerConfluenceSqlRefresh\PowerConfluenceSqlRefresh.psd1) -Force
#Import-Module PowerConfluenceSqlRefresh -Force

#import the variable $ConfluenceCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

####################################################
#  CONFIGURATION                                   #
####################################################

$options = @{
    
}

#configure the database targets and refresh type
$paramSplat = @{
    SqlInstance = "localhost"
    SqlDatabase = "Confluence"
    SyncOptions = $options
}

#configuration of the spaces to pull
$getAll = $false
if(!$getAll) {
    $paramSplat.Add("SpaceKeys", @(""))
}

####################################################
#  OPEN CONFLUENCE SESSION                               #
####################################################

Open-ConfluenceSession @ConfluenceCredentials

####################################################
#  PERFORM REFRESH                                 #
####################################################

Update-ConfluenceSql @paramSplat -Verbose

####################################################
#  CLOSE CONFLUENCE SESSION                              #
####################################################

Close-ConfluenceSession