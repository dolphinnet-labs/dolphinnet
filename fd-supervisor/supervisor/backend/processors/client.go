package processors

import (
	"context"
	"fmt"
	"time"

	"github.com/ethereum/go-ethereum/log"

	"github.com/flexdeal-chain/fd-chain/fd-service/client"
	"github.com/flexdeal-chain/fd-chain/fd-service/sources"
	"github.com/flexdeal-chain/fd-chain/fd-service/sources/caching"
)

// NewEthClient creates an Eth RPC client for event-log fetching.
func NewEthClient(ctx context.Context, logger log.Logger, m caching.Metrics, rpc string, rpcClient client.RPC,
	pollRate time.Duration, trustRPC bool, kind sources.RPCProviderKind) (*sources.L1Client, error) {
	c, err := client.NewRPCWithClient(ctx, logger, rpc, rpcClient, pollRate)
	if err != nil {
		return nil, fmt.Errorf("failed to create new RPC client: %w", err)
	}

	l1Client, err := sources.NewL1Client(c, logger, m, sources.L1ClientSimpleConfig(trustRPC, kind, 100))
	if err != nil {
		return nil, fmt.Errorf("failed to connect client: %w", err)
	}
	return l1Client, nil
}
