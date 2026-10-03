$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::Ansi

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
        # 凌晨 0~5 点：小时 +24，分钟保持两位格式
        return '{0:D2}:{1:D2}' -f ($now.Hour + 24), $now.Minute
    }
    # 6 点及以后：正常输出 HH:mm
    return $now.ToString('HH:mm')
}

function Test-IsWezTerm {
    # 1. 优先走环境变量，速度快、官方标准
    if ($env:WEZTERM_EXECUTABLE) { return $true }
    # 2. 兜底父进程检测
    try {
        $parentProc = Get-Process -Id (Get-Process -Id $PID).ParentId -ErrorAction Stop
        return $parentProc.ProcessName -in 'wezterm-gui', 'wezterm'
    } catch {
        return $false
    }
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
}
