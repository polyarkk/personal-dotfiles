# config.nu
#
# Installed by:
# version = "0.116.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.VISUAL = "code"

$env.PROMPT_COMMAND = {
    use std
    
    # 1. 先保存用户命令的退出码（后续 prompt 内命令会覆盖，必须先存）
    let last_exit = $env.LAST_EXIT_CODE | into int

    # 2. 状态指示器：命令失败显示退出码（红色），成功显示空格
    # 对应原 PowerShell 的 $? + $LASTEXITCODE 逻辑
    # Nushell 所有命令失败均会产生非0退出码，无需单独区分内置/外部命令
    let status_indicator = if $last_exit != 0 {
        $" (ansi red)($last_exit)(ansi reset) "
    } else {
        " "
    }

    let is_admin = is-admin

    # 4. 自定义时间：凌晨6点前小时+24，对应原 Get-CustomHourTime
    let now = date now
    let hour = $now | format date "%H" | into int
    let minute = $now | format date "%M"
    let time_str = if $hour < 6 {
        let h = $hour + 24
        let h_str = $h | into string | fill -a right -c '0' -w 2
        let m_str = $minute | fill -a right -c '0' -w 2
        $"$h_str:$m_str"
    } else {
        $now | format date "%H:%M"
    }
    # 时间颜色：RGB(136,68,153) 紫色，对应原 FromRgb
    let time_part = $"(ansi '#884499')($time_str)(ansi reset)"

    # 5. 计算机名：管理员红色，普通用户 RGB(221,170,204) 浅粉
    let computer_name = $env.COMPUTERNAME | str lowercase
    let computer_part = if $is_admin {
        $"(ansi red)($computer_name)(ansi reset)"
    } else {
        $"(ansi '#ddaacc')($computer_name)(ansi reset)"
    }

    # 6. 当前路径：Home 替换为 ~，蓝色
    let home_dir = "~" | path expand
    let location_part = $"(ansi blue)(pwd | str replace $home_dir '~')(ansi reset)"

    # 7. Git 分支信息，完全对应原 Write-BranchName 逻辑
    let git_part = if (".git" | path exists) {
        let branch = git rev-parse --abbrev-ref HEAD err> (std null-device) | default "" | str trim
        if ($branch | is-empty) {
            # 获取失败：无分支
            $"(ansi yellow)\(no branches yet)(ansi reset) "
        } else if $branch == "HEAD" {
            # 分离头指针，显示短哈希
            let hash = git rev-parse --short HEAD err> (std null-device) | default "" | str trim
            if ($hash | is-empty) {
                $"(ansi red)\(???)(ansi reset) "
            } else {
                $"(ansi red)\(($hash))(ansi reset) "
            }
        } else {
            # 正常分支
            $"(ansi cyan)\(($branch))(ansi reset) "
        }
    } else {
        ""
    }

    # 8. 提示符字符：管理员 #，普通用户 $，蓝色
    let prompt_char = $"(ansi blue)(if $is_admin { '#' } else { '$' })(ansi reset)"

    # 拼接最终提示符字符串
    let final_prompt = $"(ansi reset)[($time_part)]($status_indicator)($computer_part) ($location_part) ($git_part)($prompt_char) "

    # 恢复用户命令的退出码，避免 prompt 内的 git/net 等命令覆盖原值
    $env.LAST_EXIT_CODE = $last_exit | into string

    $final_prompt
}

$env.PROMPT_COMMAND_RIGHT = { "" }
$env.PROMPT_INDICATOR = ""
$env.config.show_banner = false
