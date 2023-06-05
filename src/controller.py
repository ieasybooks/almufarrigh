"""The main entrypoint from UI to the business logic.

When needed, the necessary job will be delegated to other objects.
"""

import json
import logging

from PySide6.QtCore import QObject, Slot

logger = logging.getLogger(__name__)


class Controller(QObject):

    """Controller class for handling UI interactions and business logic."""

    @Slot(None, result=None)
    def resize(self) -> None:
        logger.info("Resizing...")

    @Slot(str, result=None)
    def setAudioUrls(self, json_string: str) -> None:
        """Get list of audio urls from the front end.

        param:
        ----
            json_string (str): audio urls in json format
        """
        # Convert the JSON string back to a Python object
        data_list = json.loads(json_string)

        print("The audioFiles is in python")  # noqa: T201
        # Process the received ListModel
        print(json.dumps(data_list, indent=4))  # noqa: T201

    @Slot(str, result=None)
    def setSettings(self, json_string: str) -> None:
        """Get user defined settings from the frontend.

        param:
        ----
            json_string (str): settings in json string format
        """
        # Convert the JSON string back to a Python object
        data_list = json.loads(json_string)

        print("The Settings is in python")  # noqa: T201
        # Process the received ListModel
        print(json.dumps(data_list, indent=4))  # noqa: T201
