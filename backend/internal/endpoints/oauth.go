package endpoints

import (
	"net/http"
	"os"
	"path/filepath"
)

func ServeOauthMetadata(w http.ResponseWriter, r *http.Request) {
	srvDir := os.Getenv("SRV_DIR")
	if srvDir == "" {
		bLogger.Error("SRV_DIR environment variable is not set")
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}
	http.ServeFile(w, r, filepath.Join(srvDir, "client-metadata.json"))
}
