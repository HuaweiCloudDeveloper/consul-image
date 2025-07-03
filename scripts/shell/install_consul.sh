#!/bin/bash

# Consul安装脚本 for ARM架构 (EulerOS 2.0 HCE & Ubuntu 24.04)
# 版本: 1.0
# 作者: 你的名字
# 日期: $(date +%Y-%m-%d)

# 常量定义
CONSUL_VERSION="1.17.0"
CONSUL_URL="https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_arm64.zip"
CONSUL_DIR="/opt/consul"
CONSUL_DATA_DIR="/var/consul"
CONSUL_CONFIG_DIR="/etc/consul.d"
CONSUL_USER="consul"
CONSUL_GROUP="consul"
SERVICE_FILE="/etc/systemd/system/consul.service"

# 检查root权限
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "错误: 此脚本需要root权限执行"
        exit 1
    fi
}

# 检测系统类型
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        OS_VERSION=$VERSION_ID
    elif [ -f /etc/hce-release ]; then
        OS="hce"
        OS_VERSION=$(grep -oP '(?<=release )\d' /etc/hce-release)
    else
        echo "错误: 无法检测操作系统类型"
        exit 1
    fi

    echo "检测到操作系统: $OS $OS_VERSION"
}

# 安装必要依赖
install_dependencies() {
    echo "安装必要依赖..."

    case $OS in
        ubuntu|debian)
            apt-get update
            apt-get install -y wget unzip curl systemd
            ;;
        hce|centos|rhel)
            yum install -y wget unzip curl systemd
            ;;
        *)
            echo "错误: 不支持的操作系统: $OS"
            exit 1
            ;;
    esac

    if ! command -v wget &> /dev/null || ! command -v unzip &> /dev/null; then
        echo "错误: 依赖安装失败"
        exit 1
    fi
}

# 创建Consul用户和组
create_consul_user() {
    if ! id -u $CONSUL_USER > /dev/null 2>&1; then
        echo "创建Consul用户和组..."
        groupadd $CONSUL_GROUP
        useradd -r -g $CONSUL_GROUP -d $CONSUL_DIR -s /bin/false $CONSUL_USER
    else
        echo "Consul用户已存在，跳过创建"
    fi
}

# 下载并安装Consul
install_consul() {
    echo "下载Consul ${CONSUL_VERSION}..."
    if [ -f "/tmp/consul.zip" ]; then
        rm -f "/tmp/consul.zip"
    fi

    if ! wget -O /tmp/consul.zip $CONSUL_URL; then
        echo "错误: 下载Consul失败"
        exit 1
    fi

    echo "解压并安装Consul..."
    unzip -o /tmp/consul.zip -d /tmp
    mkdir -p $CONSUL_DIR $CONSUL_DATA_DIR $CONSUL_CONFIG_DIR
    mv /tmp/consul $CONSUL_DIR/
    rm -f /tmp/consul.zip

    # 设置权限
    chown -R $CONSUL_USER:$CONSUL_GROUP $CONSUL_DIR $CONSUL_DATA_DIR $CONSUL_CONFIG_DIR
    chmod -R 750 $CONSUL_DIR $CONSUL_DATA_DIR $CONSUL_CONFIG_DIR

    # 创建符号链接到PATH
    ln -sf $CONSUL_DIR/consul /usr/local/bin/consul
}

# 创建配置文件
create_config() {
    echo "创建基本配置文件..."

    # 主配置文件
    cat > $CONSUL_CONFIG_DIR/consul.hcl <<EOF
datacenter = "dc1"
data_dir = "$CONSUL_DATA_DIR"
log_level = "INFO"
node_name = "$(hostname)"
server = true
bootstrap_expect = 1
ui = true
bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"
EOF

    chown $CONSUL_USER:$CONSUL_GROUP $CONSUL_CONFIG_DIR/consul.hcl
    chmod 640 $CONSUL_CONFIG_DIR/consul.hcl
}

# 创建systemd服务
create_systemd_service() {
    echo "创建systemd服务..."

    cat > $SERVICE_FILE <<EOF
[Unit]
Description="HashiCorp Consul - A service mesh solution"
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=$CONSUL_CONFIG_DIR/consul.hcl

[Service]
Type=exec
User=$CONSUL_USER
Group=$CONSUL_GROUP
ExecStart=$CONSUL_DIR/consul agent -config-dir=$CONSUL_CONFIG_DIR
ExecReload=$CONSUL_DIR/consul reload
KillMode=process
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
}

# 启用并启动服务
enable_service() {
    echo "启用并启动Consul服务..."
    systemctl enable consul
    systemctl start consul

    if ! systemctl is-active --quiet consul; then
        echo "错误: Consul服务启动失败"
        journalctl -u consul --no-pager -n 20
        exit 1
    fi

    echo "Consul服务已成功启动!"
}

# 显示状态信息
show_status() {
    echo -e "\nConsul安装完成!"
    echo -e "\n状态信息:"
    systemctl status consul --no-pager -l

    echo -e "\nConsul版本信息:"
    consul version

    echo -e "\nWeb UI访问地址:"
    echo "http://$(hostname -I | awk '{print $1}'):8500"
}

# 主函数
main() {
    check_root
    detect_os
    install_dependencies
    create_consul_user
    install_consul
    create_config
    create_systemd_service
    enable_service
    show_status
}

main