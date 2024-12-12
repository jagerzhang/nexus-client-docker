#! /bin/bash
ARCH=$(uname -m)
OS=$(uname -s)
PROGRAM_DIR="$NEXUS_HOME/src/generated"
REPO_BASE="https://github.com/nexus-xyz/network-api/raw/refs/tags/${NEXUS_VERSION}/clients/cli"

if [ ! -f "$PROVER_ID_FILE" ]; then
    if [[ ! -z "$PROVER_ID" ]];then
        echo "$PROVER_ID" > "$PROVER_ID_FILE"
        echo -e "${GREEN}已保存 Prover ID: $PROVER_ID${NC}"
    else
        echo -e "${YELLOW}请用环境变量 PROVER_ID 来配置你的 Prover ID${NC}"
        exit 1
    fi
fi

download_program_files() {
    mkdir -p "$PROGRAM_DIR"
    mkdir -p "$NEXUS_HOME/src/generated"
    ln -sf "$PROGRAM_DIR" "$NEXUS_HOME/src/generated"

    local files="cancer-diagnostic fast-fib"
    for file in $files; do
        local target_path="$PROGRAM_DIR/$file"
        if [ ! -f "$target_path" ]; then
            echo -e "${YELLOW}下载 $file...${NC}"
            curl -L "$REPO_BASE/src/generated/$file" -o "$target_path"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}$file 下载完成${NC}"
                chmod +x "$target_path"
            else
                echo -e "${RED}$file 下载失败${NC}"
            fi
        fi
    done
}

if [ "$OS" = "Darwin" ]; then
    if [ "$ARCH" = "x86_64" ]; then
        echo -e "${YELLOW}启动 macOS Intel 架构 Prover...${NC}"
        ln -sf prover-macos-amd64 prover
    elif [ "$ARCH" = "arm64" ]; then
        echo -e "${YELLOW}启动 macOS ARM64 架构 Prover...${NC}"
        ln -sf prover-arm64 prover
    else
        echo -e "${RED}不支持的 macOS 架构: $ARCH${NC}"
        exit 1
    fi
elif [ "$OS" = "Linux" ]; then
    if [ "$ARCH" = "x86_64" ]; then
        echo -e "${YELLOW}启动 Linux AMD64 架构 Prover...${NC}"
        ln -sf prover-amd64 prover
elif [ "$ARCH" = "aarch64" ]; then
        echo -e "${YELLOW}启动 Linux ARM 架构 Prover...${NC}"
        ln -sf prover-aarch64 prover
    else
        echo -e "${RED}不支持的 Linux 架构: $ARCH${NC}"
        exit 1
    fi
else
    echo -e "${RED}不支持的操作系统: $OS${NC}"
    exit 1
fi

download_program_files

exec "$@"
