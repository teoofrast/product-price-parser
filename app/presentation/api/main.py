from fastapi import FastAPI


def create_app() -> FastAPI:
    app = FastAPI(
        title="My product parser API",
        description="API for parsing products from various sources",
        version="0.1.0",
    )

    return app

app = create_app()

@app.get("/")
def read_root():
    return {"message": "Hello, World!"}
