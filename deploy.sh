#!/bin/bash
# 自动部署脚本 - 曜曜记账本
# 用法: ./deploy.sh your-github-username

if [ $# -eq 0 ]; then
  echo "❌ 用法: $0 <你的 GitHub 用户名>"
  echo "例如: $0 octocat"
  exit 1
fi

USERNAME=$1
REPO_NAME="accounting-app"
REMOTE_URL="https://github.com/$USERNAME/$REPO_NAME.git"

echo "🚀 准备部署记账本到 GitHub Pages..."
echo "👤 用户名: $USERNAME"
echo "📦 仓库: $REPO_NAME"

# 初始化 Git（如果尚未初始化）
if [ ! -d .git ]; then
  echo "🔧 初始化 Git 仓库..."
  git init
  git add .
  git commit -m "feat: 初始版本 - 曜曜记账本"
else
  echo "🔄 更新现有仓库..."
  git add .
  git commit -m "chore: 更新记账本功能" || echo "⚠️ 无变更提交"
fi

# 设置远程仓库
git remote remove origin 2>/dev/null
git remote add origin "$REMOTE_URL"

# 推送到 GitHub
echo "📤 推送到 GitHub..."
git branch -M main
git push -u origin main --force

echo ""
echo "✅ 部署成功！"
echo "🌐 访问地址: https://$USERNAME.github.io/$REPO_NAME/"
echo ""
echo "💡 提示：首次使用需在 GitHub 仓库 Settings → Pages 启用 GitHub Pages（选 main 分支 /root 目录）"