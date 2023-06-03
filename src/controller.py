"""The main entrypoint from UI to the business logic.

When needed the necessary job will be delegated to another objects.
"""

import json
from PySide6.QtCore import QObject, Slot


class Controller(QObject):

    """Controller for the UI."""

    @Slot(None, result=None)
    def resize(self) -> None:
        print("resizing... ")  # noqa: T201

    @Slot(str, result=None)
    def sendListModel(self, jsonString):
        # Convert the JSON string back to a Python object
        dataList = json.loads(jsonString)

        print("The audioFiles is in python")
        # Process the received ListModel
        print(json.dumps(dataList, indent=4))
