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


echo -e "\n== 测试 Pip 访问 =="
rm -rf /tmp/proxytest && mkdir -p /tmp/proxytest
if pip download -q --retries 1 --timeout 10 --no-deps -d /tmp/proxytest requests; then
  echo "✔ Pip OK (已下载 $(ls /tmp/proxytest | wc -l) 个文件)"
else
  echo "✘ Pip 失败"; exit 1
fi

echo -e "\n== 测试 Conda 访问 =="
conda clean -y --index-cache >/dev/null 2>&1 || true
if conda search -c conda-forge zstd --info >/tmp/conda.log 2>&1; then
  echo "✔ Conda OK"; sed -n '1,12p' /tmp/conda.log
else
  echo "✘ Conda 失败，日志预览："; sed -n '1,40p' /tmp/conda.log; exit 1
fi

echo -e "\n🎉 全部测试完成"

