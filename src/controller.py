"""The main entrypoint from UI to the business logic.

When needed, the necessary job will be delegated to other objects.
"""

import logging

from PySide6.QtCore import QObject, Slot

logger = logging.getLogger(__name__)


class Controller(QObject):

    """Controller class for handling UI interactions and business logic."""

    @Slot(None, result=None)
    def resize(self) -> None:
        logger.info("Resizing...")
