"""Progress domain model."""

from dataclasses import dataclass


@dataclass
class Progress:
    """Progress data class."""

    value: float = 0.0
    remaining_time: float | None = None
