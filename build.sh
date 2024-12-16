databases:
  - name: carritocomidadb
    plan: free
    databaseName: carritocomida
    user: carritocomida

services:
  - type: web
    plan: free
    name: carritocomida
    runtime: python
    buildCommand: "./build.sh"
    startCommand: "python -m gunicorn carritocomida.asgi:application -k uvicorn.workers.UvicornWorker"
    envVars:
      - key: DATABASE_URL
        fromDatabase:
          name: carritocomidadb
          property: connectionString
      - key: SECRET_KEY
        generateValue: true
      - key: WEB_CONCURRENCY
        value: 4
