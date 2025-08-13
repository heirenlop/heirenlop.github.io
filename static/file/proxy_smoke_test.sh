#!/usr/bin/env bash
set -euo pipefail

echo "== 环境变量 =="
env | grep -iE '^(http|https)_proxy' || echo "(no http(s)_proxy env)"

echo -e "\n== Git 代理配置 =="
git config --global --get http.proxy  || echo "(no http.proxy)"
git config --global --get https.proxy || echo "(no https.proxy)"

echo -e "\n== Pip 代理配置 =="
pip config get global.proxy 2>/dev/null || echo "(no pip proxy)"

echo -e "\n== Conda 代理配置 =="
conda config --show proxy_servers 2>/dev/null || echo "(no conda proxy)"

echo -e "\n== 测试 Git 访问 =="
set +e
GIT_CURL_VERBOSE=1 git ls-remote https://github.com/NVlabs/tiny-cuda-nn.git 1>/tmp/git.refs 2>/tmp/git.log
rc=$?
if [[ $rc -eq 0 && -s /tmp/git.refs ]]; then
  echo "✔ Git OK (refs: $(wc -l < /tmp/git.refs))"
  # 证据：代理隧道建立
  grep -m1 -E 'Connection established|Proxy replied 200|Connected via proxy' /tmp/git.log || true
else
  echo "✘ Git 失败，日志预览："
  sed -n '1,60p' /tmp/git.log
fi
set -e

# ---- Pip 下载测试（自动清理）----
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir" >/dev/null 2>&1 || true' EXIT
if pip download -q --retries 1 --timeout 10 --no-deps -d "$tmpdir" requests; then
  echo "✔ Pip OK ($(ls "$tmpdir" | wc -l) files)"
else
  echo "✘ Pip 失败"
fi

# ---- Conda 索引测试（完毕后清索引）----
conda clean -y --index-cache >/dev/null 2>&1 || true
if conda search -c conda-forge zstd --info >/tmp/conda.log 2>&1; then
  echo "✔ Conda OK"; sed -n '1,12p' /tmp/conda.log
else
  echo "✘ Conda 失败"; sed -n '1,40p' /tmp/conda.log
fi
conda clean -y --index-cache >/dev/null 2>&1 || true


echo -e "\n🎉 全部测试完成"

