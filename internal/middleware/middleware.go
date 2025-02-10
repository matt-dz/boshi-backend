package middleware

import (
	"boshi-backend/internal/logger"
	"context"
	"net/http"
	"time"
)

var bLogger = logger.GetLogger()
var ctx = context.Background()

type logResponseWriter struct {
	http.ResponseWriter
	statusCode int
}

type Middleware func(http.HandlerFunc) http.HandlerFunc

/*
Chain adds middleware in a chained fashion to the HTTP handler.
The middleware is applied in the order in which it is passed.
*/
func Chain(h http.HandlerFunc, m ...Middleware) http.HandlerFunc {

	// Applied in reverse to preserve the order
	for i := len(m) - 1; i >= 0; i-- {
		h = m[i](h.ServeHTTP)
	}

	return h
}

func (lrw *logResponseWriter) WriteHeader(code int) {
	lrw.statusCode = code
	lrw.ResponseWriter.WriteHeader(code)
}

func LogRequest() Middleware {
	return func(next http.HandlerFunc) http.HandlerFunc {
		return func(w http.ResponseWriter, r *http.Request) {
			start := time.Now()
			lrw := &logResponseWriter{w, http.StatusOK}
			next.ServeHTTP(lrw, r)
			bLogger.InfoContext(ctx, "Request received", "method", r.Method, "endpoint", r.URL, "status", lrw.statusCode, "duration", time.Since(start).String())
		}
	}
}
