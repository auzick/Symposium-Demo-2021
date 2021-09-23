$ErrorActionPreference = "Stop"

##
## This script is used to add / initialize a JSS project using 'jss create'
## when this template is instantiated. It can be safely deleted.
##

Function Add-JssProject {
    Write-Host "Adding JSS sample to solution via 'jss create'..."

    if ($null -eq (Get-Command "npm" -ErrorAction SilentlyContinue)) 
    { 
       Write-Host "You must install node.js, see https://nodejs.org/" -ForegroundColor Red
       Exit 1
    }
    
    if ($null -eq (Get-Command "jss" -ErrorAction SilentlyContinue)) 
    { 
       Write-Host "Installing Sitecore JSS CLI" -ForegroundColor Green
       npm install -g @sitecore-jss/sitecore-jss-cli
    }
    
    Push-Location src
    try {
        $projectName = "basicnextjsdemo"
        Write-Host "Creating JSS Project for $projectName" -ForegroundColor Green
    
        # JSS project name transformed by our dotnet new template symbols
        $jssProjectName = "basicnextjsdemo"
        if ($jssProjectName -ne $projectName) {
            Write-Host "Transformed to valid JSS project name $jssProjectName" -ForegroundColor Yellow
        }
    
        # Construct 'jss create' arguments based on input and defaults
        $createArgs = @('create', $jssProjectName, 'nextjs')
        # Both of these values are replaced by parameters from template.json 
        $jssCreateParams = "--fetchWith REST --prerender SSG"
        $jssDefaultBranch = "--branch release/18.0.0"
        if (-not $jssCreateParams.Contains("--branch")) {
            $jssCreateParams = "$jssDefaultBranch $jssCreateParams"
        }
        $createArgs += $jssCreateParams.Split(' ')

        # Suppress 'jss create' output to avoid confusion from default instructions
        jss @createArgs | Out-Null
        Move-Item -Force $jssProjectName rendering | Out-Null
        Push-Location rendering
        try {
            jss setup `
                --instancePath "..\..\docker\deploy\platform\" `
                --layoutServiceHost "https://cm.basicnextjsdemo.localhost" `
                --apiKey "06ba5b6e-22f5-4e31-b083-531c7d181206" `
                --deployUrl "https://cm.basicnextjsdemo.localhost/sitecore/api/jss/import" `
                --deploySecret "75f277c08b5846f5a5c4aacbae308f9a" `
                --nonInteractive `
                --skipValidation | Out-Null
            Update-JssProjectFiles
        } finally {
            Pop-Location
        }
    } finally {
        Pop-Location
    }
    Write-Host "Done!"
}

Function Update-JssProjectFiles {
    Write-Host "Updating JSS sample for containerized environment" -ForegroundColor Green

    # Update .gitignore
    # Values will be consistent across developers and deployment secret is an env var
    $gitignore = ".\.gitignore"
    Set-Content -Path $gitignore -Value (
        Get-Content $gitignore |
        Select-String -NotMatch "# sitecore|scjssconfig.json|\*.deploysecret.config"
    )

    ## Remove config patches since the dotnet new template provides them
    Remove-Item -Recurse -Force .\sitecore\config
}

Add-JssProject