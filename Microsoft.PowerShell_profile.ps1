function Write-BranchName {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            $branch = git rev-parse --short HEAD
            Write-Host "($branch) " -ForegroundColor "red" -NoNewLine
        }
        else {
            Write-Host "($branch) " -ForegroundColor "cyan" -NoNewLine
        }
    } catch {
        Write-Host "(no branches yet) " -ForegroundColor "yellow" -NoNewLine
    }
}

function prompt {
    $statusIndicator = $(if ($?) { " " } else { " x_x " })
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin = $($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    $location = $(Get-Location).ToString().Replace($home, "~")
    $computerNameColor = $(if ($isAdmin) { "red" } else { "green" })
    $time = Get-Date -Format "HH:mm"
    $userPrompt = " "

    Write-Host "[" -NoNewLine
    Write-Host -ForegroundColor yellow $time -NoNewLine
    Write-Host "]" -NoNewLine
    Write-Host -ForegroundColor red $statusIndicator -NoNewLine
    Write-Host -ForegroundColor $computerNameColor $($env:computername.ToLower()) -NoNewLine
    Write-Host -ForegroundColor blue " $location " -NoNewLine
    
    if (Test-Path .git) {
        Write-BranchName
    }

    Write-Host -ForegroundColor blue $(if ($isAdmin) { "#" } else { "$" }) -NoNewLine

    return $userPrompt   
}
