#!/usr/bin/env bash
set -euo pipefail

echo "🧹 清理 git / pip / conda 代理配置..."

# ---------- conda ----------
if command -v conda >/dev/null 2>&1; then
  # 优先移除键，不支持时忽略错误
  conda config --remove-key proxy_servers.http  >/dev/null 2>&1 || true
  conda config --remove-key proxy_servers.https >/dev/null 2>&1 || true
  echo "✅ 已清理 Conda 代理"
else
  echo "ℹ 未检测到 conda，跳过 Conda 清理"
fi

# ---------- pip ----------
pip config unset global.proxy >/dev/null 2>&1 || true
echo "✅ 已清理 Pip 代理"

# ---------- git ----------
git config --global --unset http.proxy  >/dev/null 2>&1 || true
git config --global --unset https.proxy >/dev/null 2>&1 || true
git config --global --unset http.version >/dev/null 2>&1 || true
git config --global --unset http.lowSpeedLimit >/dev/null 2>&1 || true
git config --global --unset http.lowSpeedTime  >/dev/null 2>&1 || true
git config --global --unset fetch.parallel     >/dev/null 2>&1 || true
echo "✅ 已清理 Git 代理"

echo "🎉 完成！已经还原为直连状态。"
