package main

import (
	"boshi-backend/internal/endpoints"
	"boshi-backend/internal/logger"
	"boshi-backend/internal/middleware"
	"fmt"
	"net/http"
	"os"
)

var bLogger = logger.GetLogger()

func main() {
	bLogger.Info("Starting server...")

	/* Setup routes */
	mux := http.NewServeMux()

	mux.HandleFunc("/heartbeat",
		middleware.Chain(
			endpoints.Heartbeat,
			middleware.LogRequest(),
		))

	/* Setup server*/
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	server := &http.Server{Addr: fmt.Sprintf(":%s", port), Handler: mux}
	bLogger.Info("Listening on port " + port + "...")
	if err := server.ListenAndServe(); err != nil {
		bLogger.Error("Server failed to start", "error", err)
	}
}
