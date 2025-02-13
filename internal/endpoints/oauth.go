package endpoints

import (
	"net/http"
)

func ServeOauthMetadata(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "/srv/client-metadata.json")
}
