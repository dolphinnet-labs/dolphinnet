<div align="center">
  <br />
  <a href="https://github.com/dolphinnet-labs/dolphinnet">
    <img alt="Dolphinet Logo" src="./docs/assets/dolphinet.svg" width="600" />
  </a>
  <br />
  <br />

  <h1>Dolphinet</h1>

  <p><strong>🚀 高性能、EVM兼容的区块链</strong></p>

  <p>
    <a href="https://github.com/dolphinnet-labs/dolphinnet/actions/workflows/ci.yml">
      <img alt="CI Status" src="https://github.com/dolphinnet-labs/dolphinnet/actions/workflows/ci.yml/badge.svg" />
    </a>
    <a href="https://goreportcard.com/report/github.com/dolphinnet-labs/dolphinnet">
      <img alt="Go Report Card" src="https://goreportcard.com/badge/github.com/dolphinnet-labs/dolphinnet" />
    </a>
    <a href="https://codecov.io/gh/dolphinnet-labs/dolphinnet">
      <img alt="codecov" src="https://codecov.io/gh/dolphinnet-labs/dolphinnet/branch/main/graph/badge.svg" />
    </a>
    <a href="https://github.com/dolphinnet-labs/dolphinnet/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/dolphinnet-labs/dolphinnet" />
    </a>
    <a href="https://discord.gg/dolphinet">
      <img alt="Discord" src="https://img.shields.io/discord/1234567890?label=Discord&logo=discord" />
    </a>
  </p>

  <p>
    <a href="#快速开始">快速开始</a> •
    <a href="#架构">架构</a> •
    <a href="#文档">文档</a> •
    <a href="#贡献">贡献</a> •
    <a href="#许可证">许可证</a>
  </p>

  <br />
</div>

## ✨ 什么是 Dolphinet？

**Dolphinet** 是一个高性能区块链平台。它提供了完整的 Layer 1 解决方案，包括共识层、执行层、部署工具和跨链通信能力。

### 🌟 核心特性

- **⚡ 高性能**: 基于 OP Stack 的优化架构，提供低延迟和高吞吐量
- **🔒 安全可靠**: 继承以太坊的安全模型，支持跨链验证
- **🔧 EVM 兼容**: 完全兼容以太坊虚拟机，支持现有的智能合约和工具
- **🌉 跨链互通**: 内置跨链消息传递和资产桥接功能
- **🛠️ 开发者友好**: 完整的开发工具链和部署自动化

## 🚀 快速开始

### 环境要求

- Go 1.22+
- Node.js 18+
- Docker & Docker Compose
- Foundry (可选，用于智能合约开发)

### 克隆仓库

```bash
git clone https://github.com/dolphinnet-labs/dolphinnet.git
cd dolphinnet
```

### 本地开发网络

```bash
# 安装依赖
go mod download

# 启动本地开发网络
just devnet-up

# 查看服务状态
docker ps
```

### 运行节点

```bash
# 构建 dn-node
just dn-node

# 运行节点（连接到测试网）
./bin/dn-node \
  --network=op-sepolia \
  --l1=ws://localhost:8546 \
  --l1.beacon=http://localhost:4000 \
  --l2=ws://localhost:9001 \
  --p2p.listen.tcp=9222 \
  --p2p.listen.udp=9222 \
  --rpc.port=7000
```

## 🏗️ 架构

Dolphinet 采用了模块化架构，由多个核心组件组成：

```
┌─────────────────────────────────────────────────────────────┐
│                          Dolphinet                          │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐            │
│  │ dn-deployer │ │  dn-program │ │  dn-service │            │
│  │ (部署工具)   │ │ (故障证明)   │ │ (公共服务)  │            │
│  └─────────────┘ └─────────────┘ └─────────────┘            │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐            │
│  │   dn-node   │ │dn-supervisor│ │   common    │            │
│  │ (共识层)     │ │ (跨链监督)   │ │ (共享库)    │            │
│  └─────────────┘ └─────────────┘ └─────────────┘            │
├─────────────────────────────────────────────────────────────┤
│                    OP Stack (op-geth)                       │
└─────────────────────────────────────────────────────────────┘
```

### 核心组件

| 组件 | 描述 | 主要功能 |
|------|------|----------|
| [**dn-node**](dn-node/) | 共识层客户端 | 区块构建、验证和中继（Layer 1） |
| [**dn-service**](dn-service/) | 公共服务库 | 共享的区块链服务功能 |
| [**dn-deployer**](dn-deployer/) | 部署工具 | 自动化Layer 1链部署和配置 |
| [**dn-program**](dn-program/) | 证明程序 | 链下计算和证明生成 |
| [**dn-supervisor**](dn-supervisor/) | 跨链监督器 | 跨链安全验证和依赖管理 |
| [**common**](common/) | 共享库 | 合约、类型和工具函数 |

## 📚 文档

- [**📖 官方文档**](https://docs.dolphinet.io) - 完整的用户和开发者指南
- [**🏗️ 架构文档**](docs/) - 技术规范和设计文档
- [**🔧 API 文档**](https://pkg.go.dev/github.com/dolphinnet-labs/dolphinnet) - Go 包文档
- [**📋 贡献指南**](CONTRIBUTING.md) - 如何参与项目开发

### 快速链接

- [节点运行指南](dn-node/README.md)
- [部署教程](dn-deployer/README.md)
- [故障证明说明](dn-program/README.md)
- [安全审核报告](docs/security-reviews/)

## 🧪 测试

```bash
# 运行单元测试
go test ./...

# 运行集成测试
just test-integration

# 运行端到端测试
just test-e2e
```

## 🤝 贡献

我们欢迎所有形式的贡献！请查看我们的 [贡献指南](CONTRIBUTING.md) 了解详细信息。

### 开发环境设置

```bash
# 安装开发依赖
just install-dev

# 运行代码检查
just lint

# 格式化代码
just fmt
```

### 寻找任务

- [**🐛 好初学者问题**](https://github.com/dolphinnet-labs/dolphinnet/issues?q=is:open+is:issue+label:D-good-first-issue)
- [**📝 文档改进**](https://github.com/dolphinnet-labs/dolphinnet/issues?q=is:open+is:issue+label:D-documentation)
- [**🔧 功能请求**](https://github.com/dolphinnet-labs/dolphinnet/issues?q=is:open+is:issue+label:D-feature-request)

## 🌐 社区

加入我们的社区，获取帮助和分享想法：

- [**💬 Discord**](https://discord.gg/dolphinet) - 日常讨论和技术支持
- [**📧 论坛**](https://forum.dolphinet.io) - 治理讨论和提案
- [**🐦 Twitter**](https://twitter.com/dolphinet) - 最新动态和公告

## 🔒 安全

我们非常重视安全性。如果您发现安全漏洞，请勿在公开渠道报告。请按照我们的 [安全政策](SECURITY.md) 进行报告。

- [**🐛 漏洞赏金**](https://immunefi.com/bounty/dolphinnet) - 通过 Immunefi 报告漏洞
- [**📋 安全审计**](docs/security-reviews/) - 已完成的审计报告

## 📄 许可证

本项目采用 [MIT 许可证](LICENSE)。有关更多信息，请查看 [LICENSE](LICENSE) 文件。

---

<div align="center">
  <p><strong>由 <a href="https://dolphinnet-labs.com">Dolphinet Labs</a> 构建</strong></p>
  <p>
    <a href="https://github.com/dolphinnet-labs/dolphinnet">GitHub</a> •
    <a href="https://docs.dolphinet.io">文档</a> •
    <a href="https://discord.gg/dolphinet">Discord</a> •
    <a href="https://twitter.com/dolphinet_io">Twitter</a>
  </p>
</div>
