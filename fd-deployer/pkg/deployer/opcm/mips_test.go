package opcm

import (
	"testing"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/log"
	"github.com/flexdeal-chain/fd-chain/fd-deployer/pkg/deployer/broadcaster"
	"github.com/flexdeal-chain/fd-chain/fd-deployer/pkg/deployer/testutil"
	"github.com/flexdeal-chain/fd-chain/fd-deployer/pkg/env"
	"github.com/flexdeal-chain/fd-chain/fd-service/testlog"
	"github.com/stretchr/testify/require"
)

func TestDeployMIPS(t *testing.T) {
	t.Parallel()

	_, artifacts := testutil.LocalArtifacts(t)

	host, err := env.DefaultScriptHost(
		broadcaster.NoopBroadcaster(),
		testlog.Logger(t, log.LevelInfo),
		common.Address{'D'},
		artifacts,
	)
	require.NoError(t, err)

	input := DeployMIPSInput{
		MipsVersion:    1,
		PreimageOracle: common.Address{0xab},
	}

	output, err := DeployMIPS(host, input)
	require.NoError(t, err)

	require.NotEmpty(t, output.MipsSingleton)
}
