return {
    "folke/snacks.nvim",
    opts = {
        scroll = {
            enabled = false, -- Disable scrolling animations
        },
        terminal = { enabled = true },
        dashboard = {
            preset = {
                header = [[
██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗     z 
██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      z
██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z   
██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║       
███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║  z    
╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝ z     
    ]],
            },
            sections = {
                { section = "header" },
                {
                    pane = 2,
                    section = "terminal",
                    cmd = "/usr/bin/colorscript -e square",
                    height = 5,
                    padding = 1,
                },
                { section = "keys", gap = 1, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    desc = "Browse Repo",
                    padding = 1,
                    key = "b",
                    action = function()
                        Snacks.gitbrowse()
                    end,
                },
                function()
                    local in_git = Snacks.git.get_root() ~= nil
                    local remote_url = vim.fn.system({ "git", "remote", "get-url", "origin" }):gsub("\n", "")
                    local in_github = in_git and remote_url:find("github%.com") ~= nil
                    local cmds = {
                        {
                            title = "Notifications",
                            cmd = "gh notify -s -n5",
                            action = function()
                                vim.ui.open("https://github.com/notifications")
                            end,
                            key = "N",
                            icon = " ",
                            height = 5,
                            enabled = in_github,
                        },
                        {
                            title = "Open Issues",
                            cmd = "gh issue list -L 3",
                            key = "i",
                            action = function()
                                vim.fn.jobstart("gh issue list --web", { detach = true })
                            end,
                            icon = " ",
                            height = 7,
                            enabled = in_github,
                        },
                        {
                            icon = " ",
                            title = "Open PRs",
                            cmd = "gh pr list -L 3",
                            key = "P",
                            action = function()
                                vim.fn.jobstart("gh pr list --web", { detach = true })
                            end,
                            height = 7,
                            enabled = in_github,
                        },
                        {
                            icon = " ",
                            title = "Git Status",
                            cmd = [=[python3 -c '
import subprocess
import shutil


def run(command):
    return subprocess.run(command, shell=True, text=True, capture_output=True).stdout


branch = run("git branch --show-current 2>/dev/null").strip()
print(f"On branch \033[32m{branch}\033[0m" if branch else "On branch unknown")

terminal_columns = shutil.get_terminal_size((44, 20)).columns
stat_width = max(20, terminal_columns - 3)

status_map = {}
for line in run("git diff --name-status HEAD 2>/dev/null").splitlines():
    parts = line.split("\t", 1)
    if len(parts) == 2:
        status_map[parts[1]] = parts[0][:1]

stats_lines = run(f"git -c color.ui=always diff --stat={stat_width} -B -M -C HEAD 2>/dev/null").splitlines()
if not stats_lines:
    print("  Clean working tree")
else:
    colors = {
        "M": "31",
        "A": "32",
        "D": "31",
        "R": "33",
        "C": "36",
        "T": "35",
    }
    for line in stats_lines:
        if "|" not in line:
            print(line)
            continue
        file_name = line.split("|", 1)[0].strip()
        status = status_map.get(file_name, " ")
        color = colors.get(status, "37")
        print(f" \033[{color}m{status}\033[0m {line.lstrip()}")
' ]=],
                            height = 10,
                            enabled = in_git,
                        },
                    }
                    return vim.tbl_map(function(cmd)
                        return vim.tbl_extend("force", {
                            pane = 2,
                            section = "terminal",
                            padding = 1,
                            ttl = 5 * 60,
                            indent = 3,
                        }, cmd)
                    end, cmds)
                end,
                { section = "startup" },
            },
        },
    },
}
