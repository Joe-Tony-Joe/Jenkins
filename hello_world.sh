#!/bin/bash

# Linux系统硬件配置信息检测脚本

echo "================================"
echo "Linux 系统硬件配置信息"
echo "================================"
echo ""

# 系统基本信息
echo "--- 系统基本信息 ---"
echo "系统内核: $(uname -r)"
echo "操作系统: $(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d'"' -f2)"
echo "主机名: $(hostname)"
echo "当前时间: $(date)"
echo ""

# CPU信息
echo "--- CPU 信息 ---"
echo "CPU型号: $(grep 'model name' /proc/cpuinfo | head -1 | cut -d':' -f2)"
echo "CPU核心数: $(grep -c 'processor' /proc/cpuinfo)"
echo "CPU线程数: $(grep 'siblings' /proc/cpuinfo | head -1 | awk '{print $3}')"
echo "CPU主频: $(grep 'cpu MHz' /proc/cpuinfo | head -1 | awk '{print $4}' | cut -d'.' -f1) MHz"
echo "CPU缓存: $(grep 'cache size' /proc/cpuinfo | head -1 | awk -F':' '{print $2}')"
echo ""

# 内存信息
echo "--- 内存 信息 ---"
total_mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
free_mem=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
used_mem=$((total_mem - free_mem))
echo "总内存: $((total_mem / 1024)) MB ($(echo "scale=2; $total_mem / 1024 / 1024" | bc) GB)"
echo "已用内存: $((used_mem / 1024)) MB"
echo "空闲内存: $((free_mem / 1024)) MB"
echo ""

# 磁盘信息
echo "--- 磁盘信息 ---"
df -h | grep -E '^/dev/' | awk '{printf "挂载点: %-15s 总大小: %-10s 已用: %-10s 可用: %-10s 使用率: %s\n", $6, $2, $3, $4, $5}'
echo ""

# 网络接口信息
echo "--- 网络接口信息 ---"
if command -v ip &> /dev/null; then
    ip addr show | grep -E 'inet |link/ether' | awk 'NR % 2 {printf "接口: %s ", $NF; next} {print "MAC: " $2}'
else
    ifconfig 2>/dev/null | grep -E 'inet |HWaddr' || echo "网络工具不可用"
fi
echo ""

# GPU信息 (如果有)
echo "--- GPU 信息 ---"
if command -v lspci &> /dev/null; then
    gpu_info=$(lspci | grep -i 'VGA\|3D')
    if [ -n "$gpu_info" ]; then
        echo "$gpu_info"
    else
        echo "未检测到GPU"
    fi
else
    echo "GPU检测工具不可用"
fi
echo ""

# PCI设备信息
echo "--- 主要设备信息 ---"
if command -v lspci &> /dev/null; then
    echo "PCI设备列表:"
    lspci | head -10
else
    echo "lspci工具不可用"
fi
echo ""

# 系统负载
echo "--- 系统负载 ---"
uptime
echo ""

echo "================================"
echo "硬件配置检测完成"
echo "================================"