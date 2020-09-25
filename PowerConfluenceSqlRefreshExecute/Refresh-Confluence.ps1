#import modules
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\..\PowerAtlassianCore\PowerAtlassianCore\PowerAtlassianCore.psm1)
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\..\PowerConfluence\PowerConfluence\PowerConfluence.psm1)
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\..\PowerAtlassianSqlRefreshCore\PowerAtlassianSqlRefreshCore\PowerAtlassianSqlRefreshCore.psm1) -Force
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\..\PowerConfluenceSqlRefresh\PowerConfluenceSqlRefresh\PowerConfluenceSqlRefresh.psm1) -Force
#Import-Module PowerConfluenceSqlRefresh -Verbose -Force

#import the variable $ConfluenceCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

####################################################
#  CONFIGURATION                                   #
####################################################

$options = @{
    Users = $false
    Groups = $false
    Spaces = @{
        Permissions = $true
    }
}

#configure the database targets and refresh type

$paramSplat = @{
    SqlInstance = "localhost"
    SqlDatabase = "Confluence"
    #SyncOptions = $options
}

#configuration of the spaces to pull
$getAll = $true
if(!$getAll) {
    $paramSplat.Add("SpaceKeys", @("GSIS"))
}

####################################################
#  OPEN CONFLUENCE SESSION                         #
####################################################

Open-ConfluenceSession @ConfluenceCredentials

####################################################
#  PERFORM REFRESH                                 #
####################################################

$success = Update-ConfluenceSql @paramSplat -Verbose

####################################################
#  CLOSE CONFLUENCE SESSION                        #
####################################################

Close-ConfluenceSession