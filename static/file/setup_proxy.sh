#!/usr/bin/env bash
set -euo pipefail

HOST="${1:-}"
PORT="${2:-}"
SCHEME="${3:-http}"   # 可选: http | socks5

if [[ -z "${HOST}" || -z "${PORT}" ]]; then
  echo "用法: $0 <HOST_IP> <PORT> [http|socks5]"
  echo "示例: $0 192.168.0.242 10811 http"
  exit 1
fi

PROXY_URI="${SCHEME}://${HOST}:${PORT}"

echo "➡ 设置代理为: ${PROXY_URI}"

# ---------- conda ----------
if command -v conda >/dev/null 2>&1; then
  echo "🔧 配置 Conda 代理..."
  conda config --set proxy_servers.http  "${PROXY_URI}" || true
  conda config --set proxy_servers.https "${PROXY_URI}" || true
  echo "✅ Conda 代理已配置"
else
  echo "ℹ 未检测到 conda，跳过 Conda 配置"
fi

# ---------- pip ----------
echo "🔧 配置 Pip 代理..."
pip config set global.proxy "${PROXY_URI}" >/dev/null
echo "✅ Pip 代理已配置"

# ---------- git ----------
echo "🔧 配置 Git 代理..."
git config --global http.proxy  "${PROXY_URI}"
git config --global https.proxy "${PROXY_URI}"
# 稳定性优化：禁用HTTP/2断流判定，放宽低速
git config --global http.version HTTP/1.1
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
git config --global fetch.parallel 4
echo "✅ Git 代理已配置"

# ---------- 快速自检 ----------
echo "🔍 代理连通性测试..."
if [[ "${SCHEME}" == "http" ]]; then
  curl -I --max-time 10 --proxy "${PROXY_URI}" https://www.google.com | head -n1 || {
    echo "❌ HTTP 代理连通失败：${PROXY_URI}"; exit 1; }
else
  curl -I --max-time 10 --socks5 "${HOST}:${PORT}" https://www.google.com | head -n1 || {
    echo "❌ SOCKS5 代理连通失败：${PROXY_URI}"; exit 1; }
fi

echo "🔎 当前配置："
if command -v conda >/dev/null 2>&1; then
  conda config --show proxy_servers | sed '/^proxy_servers:/!d;$!N;s/\n/ /'
fi
echo "Pip proxy = $(pip config get global.proxy 2>/dev/null || echo none)"
echo "Git http.proxy  = $(git config --global --get http.proxy)"
echo "Git https.proxy = $(git config --global --get https.proxy)"

echo "🎉 完成！git / pip / conda 都已走 ${PROXY_URI}"
