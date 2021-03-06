#import modules
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\..\PowerAtlassianCore\PowerAtlassianCore\PowerAtlassianCore.psm1) -Force
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\..\PowerJira\PowerJira\PowerJira.psm1) -Force
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\..\PowerAtlassianSqlRefreshCore\PowerAtlassianSqlRefreshCore\PowerAtlassianSqlRefreshCore.psm1) -Force
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\..\PowerJiraSqlRefresh\PowerJiraSqlRefresh\PowerJiraSqlRefresh.psm1) -Force
#Import-Module PowerJiraSqlRefresh -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

####################################################
#  CONFIGURATION                                   #
####################################################

$options = @{
    ProjectCategories = $false
    StatusCategories = $false
    Statuses = $false
    Resolutions = $false
    Priorities = $false
    IssueLinkTypes = $false
    Users = $false
    Projects = @{
        Versions = $false
        Components = $false
        Actors = $true
    }
    Worklogs = $false
    Issues = $false
}

#configure the database targets and refresh type
$paramSplat = @{
    SqlInstance = "localhost"
    SqlDatabase = "Jira"
    RefreshType = (Get-JiraRefreshTypes).Full
    #SyncOptions = $options
}

#configuration of the projects to pull
$getAll = $false
if(!$getAll) {
    $paramSplat.Add("ProjectKeys", @("GROPGDIS","GDISPROJ","GSIS"))
}

####################################################
#  OPEN JIRA SESSION                               #
####################################################

Open-JiraSession @JiraCredentials

####################################################
#  PERFORM REFRESH                                 #
####################################################

$success = Update-JiraSql @paramSplat -Verbose

####################################################
#  CLOSE JIRA SESSION                              #
####################################################

Close-JiraSession