import json


class TokenManager:
    def __init__(self, filename: str | None = None) -> None:
        self.filename = filename or "tokens.json"

    def read_tokens(self) -> dict:
        try:
            with open(self.filename) as reader:
                return json.load(reader)
        except FileNotFoundError:
            return {}

    def save_tokens(self, tokens: dict):
        with open(self.filename, "w") as writer:
            json.dump(tokens, writer)
