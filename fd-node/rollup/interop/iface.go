package interop

import (
	"context"

	"github.com/ethereum/go-ethereum/log"

	"github.com/flexdeal-chain/fd-chain/fd-node/rollup"
	"github.com/flexdeal-chain/fd-chain/fd-node/rollup/event"
	"github.com/flexdeal-chain/fd-chain/fd-node/rollup/interop/managed"
	"github.com/flexdeal-chain/fd-chain/fd-node/rollup/interop/standard"
	opmetrics "github.com/flexdeal-chain/fd-chain/fd-service/metrics"
)

type SubSystem interface {
	event.Deriver
	event.AttachEmitter
	Start(ctx context.Context) error
	Stop(ctx context.Context) error
}

var _ SubSystem = (*managed.ManagedMode)(nil)
var _ SubSystem = (*standard.StandardMode)(nil)

type L1Source interface {
	managed.L1Source
}

type L2Source interface {
	managed.L2Source
}

type Setup interface {
	Setup(ctx context.Context, logger log.Logger, rollupCfg *rollup.Config, l2 L2Source, m opmetrics.RPCMetricer) (SubSystem, error)
	Check() error
}
