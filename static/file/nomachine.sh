sudo tee /usr/local/bin/nxm >/dev/null <<'EOF'
#!/usr/bin/env bash
# NoMachine 快捷控制脚本
# 用法: nxm start|stop|restart|status|enable|disable

NXBIN="/usr/NX/bin/nxserver"

if [[ ! -x "$NXBIN" ]]; then
  echo "错误: $NXBIN 不存在或不可执行。" >&2
  exit 1
fi

case "${1:-}" in
    start)
        sudo "$NXBIN" --startup
        ;;
    stop)
        sudo "$NXBIN" --shutdown
        ;;
    restart)
        sudo "$NXBIN" --restart
        ;;
    status)
        "$NXBIN" --status
        ;;
    enable)
        sudo "$NXBIN" --enable
        ;;
    disable)
        sudo "$NXBIN" --disable
        ;;
    *)
        echo "用法: nxm {start|stop|restart|status|enable|disable}"
        exit 1
        ;;
esac
EOF

