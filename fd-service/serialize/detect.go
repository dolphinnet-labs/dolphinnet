package serialize

import (
	"os"
	"strings"

	"github.com/flexdeal-chain/fd-chain/fd-service/ioutil"
	"github.com/flexdeal-chain/fd-chain/fd-service/jsonutil"
)

func Write[X Serializable](outputPath string, x X, perm os.FileMode) error {
	if IsBinaryFile(outputPath) {
		return WriteSerializedBinary(x, ioutil.ToStdOutOrFileOrNoop(outputPath, perm))
	}
	return jsonutil.WriteJSON[X](x, ioutil.ToStdOutOrFileOrNoop(outputPath, perm))
}

func IsBinaryFile(path string) bool {
	return strings.HasSuffix(path, ".bin") || strings.HasSuffix(path, ".bin.gz")
}
