<div align="center">
  <br />
  <br />
  <a href="https://flexdealchain.com"><img alt="The Web3 Chain" src="./docs/assets/flexdealchain.svg" width=600></a>
  <br />
  <h3><a href="https://flexdealchain.com">The Web3 Chain</a> is Ethereum, scaled.</h3>
  <br />
</div>

**Table of Contents**

<!--TOC-->

- [What is FlexDeal Chain?](#what-is-flexdealchain)
- [Documentation](#documentation)
- [Specification](#specification)
- [Community](#community)
- [Contributing](#contributing)
- [Security Policy and Vulnerability Reporting](#security-policy-and-vulnerability-reporting)
- [Directory Structure](#directory-structure)
- [Development and Release Process](#development-and-release-process)
  - [Overview](#overview)
  - [Production Releases](#production-releases)
  - [Development branch](#development-branch)
- [License](#license)

<!--TOC-->

## What is FlexDeal Chain?

[flexdealchain](https://www.flexdealchain.com/) is a project dedicated to scaling Ethereum's technology and expanding its ability to coordinate people from across the world to build effective decentralized economies and governance systems. The [flexdealchain Collective](https://www.flexdealchain.com/vision) builds open-source software that powers scalable blockchains and aims to address key governance and economic challenges in the wider Ethereum ecosystem. flexdealchain operates on the principle of **impact=profit**, the idea that individuals who positively impact the Collective should be proportionally rewarded with profit. **Change the incentives and you change the world.**

## Documentation

- If you want to build on top of FlexDeal Chain Mainnet, refer to the [FlexDeal Chain Documentation](https://docs.flexdealchain.com)
- If you want to build your own chain based FlexDeal Chain, refer to the [FlexDeal Chain Guide](https://docs.flexdealchain.com/stack/getting-started) and make sure to understand this repository's [Development and Release Process](#development-and-release-process)

## Specification

Detailed specifications for the FlexDeal Chain can be found within the [FlexDeal Chain Specs](https://github.com/flexdealchain-network/specs) repository.

## Community

General discussion happens most frequently on the [FlexDeal Chain discord](https://discord.gg/flexdealchain).
Governance discussion can also be found on the [FlexDeal Chain Governance Forum](https://gov.flexdealchain.com/).

## Contributing

The FlexDeal Chain is a collaborative project. By collaborating on free, open software and shared standards, the flexdealchain Collective aims to prevent siloed software development and rapidly accelerate the development of the Ethereum ecosystem. Come contribute, build the future, and redefine power, together.

[CONTRIBUTING.md](./CONTRIBUTING.md) contains a detailed explanation of the contributing process for this repository. Make sure to use the [Developer Quick Start](./CONTRIBUTING.md#development-quick-start) to properly set up your development environment.

[Good First Issues](https://github.com/flexdealchain-network/flexdealchain/issues?q=is:open+is:issue+label:D-good-first-issue) are a great place to look for tasks to tackle if you're not sure where to start, and see [CONTRIBUTING.md](./CONTRIBUTING.md) for info on larger projects.

## Security Policy and Vulnerability Reporting

Please refer to the canonical [Security Policy](https://github.com/flexdealchain-network/.github/blob/master/SECURITY.md) document for detailed information about how to report vulnerabilities in this codebase.
Bounty hunters are encouraged to check out the [FlexDeal Chain Immunefi bug bounty program](https://immunefi.com/bounty/flexdealchain/).

## Directory Structure

<pre>
├── <a href="./docs">docs</a>: A collection of documents including audits and post-mortems
├── <a href="./roothash-chain-ops">roothash-chain-ops</a>: State surgery utilities
├── <a href="./fd-node">fd-node</a>: consensus-layer of flexdealFlexDeal Chain
├── <a href="./fd-service">fd-service</a>: Common codebase utilities
├── <a href="./ops">ops</a>: Various operational packages
├── <a href="./packages">packages</a>
│   ├── <a href="./packages/contracts-flexdealchain">contracts-flexdealchain</a>: FlexDeal Chain smart contracts
</pre>

## Development and Release Process

### Overview

Please read this section carefully if you're planning to fork or make frequent PRs into this repository.

### Production Releases

TBD

### Development branch

TBD

## License

All other files within this repository are licensed under the [MIT License](https://github.com/flexdealchain-network/flexdealchain/blob/master/LICENSE) unless stated otherwise.
