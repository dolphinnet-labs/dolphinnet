<div align="center">
  <br />
  <a href="https://github.com/dolphinnet-labs/dolphinnet">
    <img alt="Dolphinet Logo" src="./docs/assets/dolphinet.svg" width="600" />
  </a>
  <br />
  <br />

  <h1>Dolphinet</h1>

  <p><strong>🚀 High-Performance, EVM-Compatible Blockchain</strong></p>

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
    <a href="#quick-start">Quick Start</a> •
    <a href="#architecture">Architecture</a> •
    <a href="#documentation">Documentation</a> •
    <a href="#contributing">Contributing</a> •
    <a href="#license">License</a>
  </p>

  <br />
</div>

## ✨ What is Dolphinet?

**Dolphinet** is a high-performance blockchain platform. It provides a complete Layer 1 solution, including consensus layer, execution layer, deployment tools, and cross-chain communication capabilities.

### 🌟 Core Features

- **⚡ High Performance**: Optimized architecture based on OP Stack, providing low latency and high throughput
- **🔒 Secure & Reliable**: Inherits Ethereum's security model with cross-chain verification support
- **🔧 EVM Compatible**: Fully compatible with Ethereum Virtual Machine, supporting existing smart contracts and tools
- **🌉 Cross-Chain Interoperability**: Built-in cross-chain messaging and asset bridging functionality
- **🛠️ Developer Friendly**: Complete development toolchain and deployment automation

## 🚀 Quick Start

### Prerequisites

- Go 1.22+
- Node.js 18+
- Docker & Docker Compose
- Foundry (optional, for smart contract development)

### Clone Repository

```bash
git clone https://github.com/dolphinnet-labs/dolphinnet.git
cd dolphinnet
```

### Local Development Network

```bash
# Install dependencies
go mod download

# Start local development network
just devnet-up

# Check service status
docker ps
```

### Run Node

```bash
# Build dn-node
just dn-node

# Run node (connect to testnet)
./bin/dn-node \
  --network=op-sepolia \
  --l1=ws://localhost:8546 \
  --l1.beacon=http://localhost:4000 \
  --l2=ws://localhost:9001 \
  --p2p.listen.tcp=9222 \
  --p2p.listen.udp=9222 \
  --rpc.port=7000
```

## 🏗️ Architecture

Dolphinet adopts a modular architecture composed of multiple core components:

```
┌─────────────────────────────────────────────────────────────┐
│                          Dolphinet                          │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐            │
│  │ dn-deployer │ │  dn-program │ │  dn-service │            │
│  │ (Deployment) │ │ (Fault Proof)│ │ (Services)  │            │
│  └─────────────┘ └─────────────┘ └─────────────┘            │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐            │
│  │   dn-node   │ │dn-supervisor│ │   common    │            │
│  │ (Consensus) │ │ (Supervisor) │ │ (Common)   │            │
│  └─────────────┘ └─────────────┘ └─────────────┘            │
├─────────────────────────────────────────────────────────────┤
│                    OP Stack (op-geth)                       │
└─────────────────────────────────────────────────────────────┘
```

### Core Components

| Component | Description | Main Functions |
|-----------|-------------|----------------|
| [**dn-node**](dn-node/) | Consensus Layer Client | Block building, validation and relaying (Layer 1) |
| [**dn-service**](dn-service/) | Shared Service Library | Common blockchain service functionality |
| [**dn-deployer**](dn-deployer/) | Deployment Tool | Automated Layer 1 chain deployment and configuration |
| [**dn-program**](dn-program/) | Proof Program | Off-chain computation and proof generation |
| [**dn-supervisor**](dn-supervisor/) | Cross-Chain Supervisor | Cross-chain security verification and dependency management |
| [**common**](common/) | Shared Library | Contracts, types, and utility functions |

## 📚 Documentation

- [**📖 Official Documentation**](https://docs.dolphinet.io) - Complete user and developer guide
- [**🏗️ Architecture Documentation**](docs/) - Technical specifications and design documents
- [**🔧 API Documentation**](https://pkg.go.dev/github.com/dolphinnet-labs/dolphinnet) - Go package documentation
- [**📋 Contributing Guide**](CONTRIBUTING.md) - How to contribute to the project

### Quick Links

- [Node Operation Guide](dn-node/README.md)
- [Deployment Tutorial](dn-deployer/README.md)
- [Fault Proof Documentation](dn-program/README.md)
- [Security Audit Reports](docs/security-reviews/)

## 🧪 Testing

```bash
# Run unit tests
go test ./...

# Run integration tests
just test-integration

# Run end-to-end tests
just test-e2e
```

## 🤝 Contributing

We welcome all forms of contributions! Please check our [Contributing Guide](CONTRIBUTING.md) for detailed information.

### Development Environment Setup

```bash
# Install development dependencies
just install-dev

# Run code checks
just lint

# Format code
just fmt
```

### Finding Tasks

- [**🐛 Good First Issues**](https://github.com/dolphinnet-labs/dolphinnet/issues?q=is:open+is:issue+label:D-good-first-issue)
- [**📝 Documentation Improvements**](https://github.com/dolphinnet-labs/dolphinnet/issues?q=is:open+is:issue+label:D-documentation)
- [**🔧 Feature Requests**](https://github.com/dolphinnet-labs/dolphinnet/issues?q=is:open+is:issue+label:D-feature-request)

## 🌐 Community

Join our community for help and to share ideas:

- [**💬 Discord**](https://discord.gg/dolphinet) - Daily discussions and technical support
- [**📧 Forum**](https://forum.dolphinet.io) - Governance discussions and proposals
- [**🐦 Twitter**](https://twitter.com/dolphinet) - Latest updates and announcements

## 🔒 Security

We take security very seriously. If you discover a security vulnerability, please do not report it through public channels. Please follow our [Security Policy](SECURITY.md) for reporting.

- [**🐛 Bug Bounty**](https://immunefi.com/bounty/dolphinnet) - Report vulnerabilities through Immunefi
- [**📋 Security Audits**](docs/security-reviews/) - Completed audit reports

## 📄 License

This project is licensed under the [MIT License](LICENSE). For more information, please see the [LICENSE](LICENSE) file.

---

<div align="center">
  <p><strong>Built by <a href="https://dolphinnet-labs.com">Dolphinet Labs</a></strong></p>
  <p>
    <a href="https://github.com/dolphinnet-labs/dolphinnet">GitHub</a> •
    <a href="https://docs.dolphinet.io">Documentation</a> •
    <a href="https://discord.gg/dolphinet">Discord</a> •
    <a href="https://twitter.com/dolphinet">Twitter</a>
  </p>
</div>
