package p2p

import (
	"context"
	opsigner "github.com/flexdeal-chain/fd-chain/fd-service/signer"
)

type Signer interface {
	opsigner.BlockSigner
}

type PreparedSigner struct {
	Signer opsigner.BlockSigner
}

func (p *PreparedSigner) SetupSigner(ctx context.Context) (Signer, error) {
	return p.Signer, nil
}

type SignerSetup interface {
	SetupSigner(ctx context.Context) (Signer, error)
}
