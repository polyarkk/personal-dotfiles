# $PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::Ansi

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

function Get-CustomHourTime {
    $now = Get-Date

    if ($now.Hour -lt 6) {
        return '{0:D2}:{1:D2}' -f ($now.Hour + 24), $now.Minute
    }

    return $now.ToString('HH:mm')
}

# in wezterm:
# config.set_environment_variables = {
#     WEZ = "true"
# }
function Test-IsWezTerm {
    # if ($env:WEZ) { return $true }

    return $false
}

function prompt {
    $statusIndicator = $(if ($?) { " " } else { " x_x " })
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin = $($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    $location = $(Get-Location).ToString().Replace($home, "~")
    $time = Get-CustomHourTime
    $userPrompt = " "

    Write-Host "[" -NoNewLine 
    Write-Host "$($PSStyle.Foreground.FromRgb(136, 68, 153))$time$($PSStyle.Reset)" -NoNewLine
    Write-Host "]" -NoNewLine
    Write-Host -ForegroundColor red $statusIndicator -NoNewLine
    
    if ($isAdmin) {
		Write-Host -ForegroundColor red $($env:computername.ToLower()) -NoNewLine
	} else {
		Write-Host "$($PSStyle.Foreground.FromRgb(0xddaacc))$($env:computername.ToLower())" -NoNewLine
	}
    
    Write-Host -ForegroundColor blue " $location " -NoNewLine
    
    if (Test-Path .git) {
        Write-BranchName
    }

    Write-Host -ForegroundColor blue $(if ($isAdmin) { "#" } else { "$" }) -NoNewLine

    return $userPrompt   
}

fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
Import-Module 'gsudoModule'

function proxy {
    $env:HTTP_PROXY='http://127.0.0.1:7897'
    $env:HTTPS_PROXY='http://127.0.0.1:7897'
    Write-Host "proxy attached" -ForegroundColor Green
}

# 配套清除代理命令（可选）
function unproxy {
    Remove-Item Env:HTTP_PROXY -ErrorAction SilentlyContinue
    Remove-Item Env:HTTPS_PROXY -ErrorAction SilentlyContinue
    Write-Host "proxy detached" -ForegroundColor Red
}

if (Test-IsWezTerm) {
    fastfetch
} else {
    Write-Host ""
    Write-Host "        " -NoNewLine 
    D:\bin\hitokoto
    Write-Host ""
}