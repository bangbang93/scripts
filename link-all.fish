#!/usr/bin/env fish

# 将所有bin脚本链接到 ~/.local/bin 目录

# 1. 获取当前目录
set current_dir (pwd)

# 2. 获取所有 bin 脚本
set bin_scripts (find $current_dir -type f -name "*.fish")

# 3. 创建 ~/.local/bin 目录
if not test -d ~/.local/bin
    mkdir -p ~/.local/bin
end

# 4. 遍历所有 bin 脚本
for script in $bin_scripts
    set script_name (basename $script)

    ln -sf $script ~/.local/bin/$script_name
end

