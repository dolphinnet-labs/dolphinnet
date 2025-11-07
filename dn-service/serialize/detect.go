package serialize

import (
	"os"
	"strings"

	"github.com/dolphinnet-labs/dolphinnet/dn-service/ioutil"
	"github.com/dolphinnet-labs/dolphinnet/dn-service/jsonutil"
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
