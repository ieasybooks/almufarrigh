"""Token manager module."""

import json
from pathlib import Path
from typing import cast


class TokenManager:
    """Token manager class."""

    def __init__(self, filename: str | None = None) -> None:
        """Initialize the token manager.

        :param filename: The filename to save the tokens to.
        """
        self.filename: Path = Path(filename or "tokens.json")

    def read_tokens(self) -> dict[str, str]:
        """Read the tokens from the file."""
        return cast(
            dict[str, str],
            json.loads(self.filename.read_text(encoding="utf-8")) if self.filename.exists() else {},
        )

    def save_tokens(self, tokens: dict[str, str]) -> None:
        """Save the tokens to the file."""
        self.filename.write_text(json.dumps(tokens, ensure_ascii=False), encoding="utf-8")
