package endpoints

import (
	"boshi-backend/internal/logger"
	"context"
	"net/http"
)

var bLogger = logger.GetLogger()

func Heartbeat(w http.ResponseWriter, r *http.Request) {
	ctx := context.Background()
	bLogger.DebugContext(ctx, "Heartbeat endpoint hit")
}
