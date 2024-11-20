package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
)

func main() {

	r := chi.NewMux()

	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Ello"))
	})
	r.HandleFunc("/deeper", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("deeper"))
	})

	server := http.Server{
		Addr:    ":8001",
		Handler: r,
	}

	fmt.Println("serving")
	err := server.ListenAndServe()
	if err != nil {
		log.Fatal(err)
	}
}
