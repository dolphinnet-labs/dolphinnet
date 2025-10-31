package main

import (
	"context"
	"os"

	"github.com/urfave/cli/v2"

	"github.com/ethereum/go-ethereum/log"

	opservice "github.com/flexdeal-chain/fd-chain/fd-service"
	"github.com/flexdeal-chain/fd-chain/fd-service/cliapp"
	"github.com/flexdeal-chain/fd-chain/fd-service/ctxinterrupt"
	oplog "github.com/flexdeal-chain/fd-chain/fd-service/log"
	"github.com/flexdeal-chain/fd-chain/fd-service/metrics/doc"
	"github.com/flexdeal-chain/fd-chain/fd-supervisor/config"
	"github.com/flexdeal-chain/fd-chain/fd-supervisor/flags"
	"github.com/flexdeal-chain/fd-chain/fd-supervisor/metrics"
	"github.com/flexdeal-chain/fd-chain/fd-supervisor/supervisor"
)

var (
	Version   = "v0.0.0"
	GitCommit = ""
	GitDate   = ""
)

func main() {
	ctx := ctxinterrupt.WithSignalWaiterMain(context.Background())
	err := run(ctx, os.Args, fromConfig)
	if err != nil {
		log.Crit("Application failed", "message", err)
	}
}

func run(ctx context.Context, args []string, fn supervisor.MainFn) error {
	oplog.SetupDefaults()

	app := cli.NewApp()
	app.Flags = cliapp.ProtectFlags(flags.Flags)
	app.Version = opservice.FormatVersion(Version, GitCommit, GitDate, "")
	app.Name = "fd-supervisor"
	app.Usage = "fd-supervisor monitors cross-core interop messaging"
	app.Description = "The fd-supervisor monitors cross-core interop messaging by pre-fetching events and then resolving the cross-core dependencies to answer safety queries."
	app.Action = cliapp.LifecycleCmd(supervisor.Main(app.Version, fn))
	app.Commands = []*cli.Command{
		{
			Name:        "doc",
			Subcommands: doc.NewSubcommands(metrics.NewMetrics("default")),
		},
	}
	return app.RunContext(ctx, args)
}

func fromConfig(ctx context.Context, cfg *config.Config, logger log.Logger) (cliapp.Lifecycle, error) {
	return supervisor.SupervisorFromConfig(ctx, cfg, logger)
}
