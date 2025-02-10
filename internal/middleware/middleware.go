package middleware

import (
	"boshi-backend/internal/logger"
	"context"
	"net/http"
)

var bLogger = logger.GetLogger()
var ctx = context.Background()

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

func LogRequest() Middleware {
	return func(next http.HandlerFunc) http.HandlerFunc {
		return func(w http.ResponseWriter, r *http.Request) {
			bLogger.InfoContext(ctx, "Request received", "method", r.Method, "url", r.URL.String())
			next.ServeHTTP(w, r)
		}
	}
}

func LogResponse() Middleware {
	return func(next http.HandlerFunc) http.HandlerFunc {
		return func(w http.ResponseWriter, r *http.Request) {
			next.ServeHTTP(w, r)
			bLogger.InfoContext(ctx, "Response sent", "status", w.Header().Get("Status"))
		}
	}
}
