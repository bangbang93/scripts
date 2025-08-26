#!/usr/bin/env fish

# 将当前分支合并到 develop 分支

# 1. 获取当前分支名称
set current_branch (git rev-parse --abbrev-ref HEAD)

# 2. 检查当前分支是否为 develop
if test "$current_branch" != "develop"
    echo "当前分支不是 develop"
    exit 1
end

# 3. 检查当前分支是否有未提交的更改
if test (git status --porcelain | wc -l) -ne 0
    echo "当前分支有未提交的更改，请先提交或暂存更改"
    exit 1
end

# 4. 切换到 test 分支
git switch test

git pull

# 5. 合并到 test 分支
git merge $current_branch
if test $status -ne 0
    echo "合并有冲突，请解决冲突后再提交"
    exit 1
end

# 6. 推送到远程 test 分支
git push origin test
if test $status -ne 0
    echo "推送到远程 test 分支失败，请检查"
    exit 1
end
echo "成功将当前分支 '$current_branch' 合并到 test 分支并推送到远程"

# 7. 切换回原来的分支
git switch $current_branch
