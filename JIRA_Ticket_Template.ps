# Name: JIRA_Ticket_Template
# Date Created: 2018/04/07
# Created By: Michael Fitzgerald

<#

.SYNOPSIS
Meant as a work around for the "The Scheduler" plugin for Jira. This script is meant to be
used with a task scheduler to generate tickets for daily recurring tasks.
.DESCRIPTION

.PARAMETER username
The username of the JIRA user opening the issue
.PARAMETER password 
The password of the JIRA user opening the issue
.PARAMETER projectKey 
The JIRA project key
.PARAMETER target 
The base URL of the JIRA cloud application, IE.  https://company.atlassian.net
.PARAMETER issueType 
The Issue Type of the JIRA request
.PARAMETER component
The Component to add to the JIRA request
.PARAMETER summary 
The Summary to add to the JIRA request
.PARAMETER description 
The Description to add to the JIRA request


.EXAMPLE
Create a JIRA Ticket automatically
JIRA_Ticket_Template.ps1 -username MyJiraUsername -password MyJiraPassword

#>
[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True)]
  [string]$username,
  
  [Parameter(Mandatory=$True)]
  [string]$password,
    
  [Parameter(Mandatory=$False)]
  [string]$projectKey = "",

  [Parameter(Mandatory=$False)]
  [string] $target = "https://company.atlassian.net",

  [Parameter(Mandatory=$False)]
  [string] $issueType = "",
  
  [Parameter(Mandatory=$False)]
  [string] $component = "",

  [Parameter(Mandatory=$False)]
  [string] $summary = "",

  [Parameter(Mandatory=$False)]
  [string] $description = ""
)



# Defines the JSON using the above variable for the POST request
[string] $body = "{`"fields`":{`"project`":{`"key`":`"$projectKey`"},`"issuetype`":{`"name`":`"$issueType`"},`"summary`":`"$summary`",`"description`":`"$description`",`"components`":[{`"name`":`"$component`"}]}}"

# Uses the above variables to make a POST request to the JIRA api using the JSON defined in $body
try {
    $basicAuth = "Basic " + [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($Username):$Password"))
    $headers = @{
        "Authorization" = $basicAuth
        "Content-Type"="application/json"
    }
    $requestUri = "$target/rest/api/2/issue"
    $response = Invoke-RestMethod -Uri $requestUri -Method POST -Headers $headers -Body $body
    Write-Output "ID: $($response.id)"
    Write-Output "Key: $($response.key)"
    Write-Output "Self: $($response.self)"    
}
catch {
    Write-Warning "Remote Server Response: $($_.Exception.Message)"
    Write-Output "Status Code: $($_.Exception.Response.StatusCode)"
	[System.Environment]::Exit(1)
}