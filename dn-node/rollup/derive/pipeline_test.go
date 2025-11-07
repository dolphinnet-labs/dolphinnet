package derive

import "github.com/dolphinnet-labs/dolphinnet/dn-service/testutils"

var _ L1Fetcher = (*testutils.MockL1Source)(nil)

var _ Metrics = (*testutils.TestDerivationMetrics)(nil)
