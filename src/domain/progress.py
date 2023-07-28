from dataclasses import dataclass


@dataclass
class Progress:
    value: float = 0.0
    remaining_time: float = None
