import re
from pydantic import BaseModel
from configparser import ConfigParser
from typing import List, Type, TypeVar

T = TypeVar('T', bound=BaseModel)


class AppConfig(BaseModel):
    download_json: bool
    convert_engine: str
    save_location: str
    word_count: int
    is_wit_engine: bool
    export_vtt: bool
    drop_empty_parts: bool
    max_part_length: float
    wit_convert_key: str
    whisper_model: str
    convert_language: str
    export_srt: bool
    export_txt: bool

    def get_output_formats(self) -> List[str]:
        formats = {
            'srt': self.export_srt,
            'vtt': self.export_vtt,
            'txt': self.export_txt
        }
        return [key for key, value in formats.items() if value]


class CaseSensitiveConfigParser(ConfigParser):
    def optionxform(self, optionstr) -> str:
        return optionstr

    @staticmethod
    def camel_to_snake(camel_case: str) -> str:
        snake_case = re.sub(r'([a-z0-9])([A-Z])', r'\1_\2', camel_case)
        return snake_case.lower()

    @classmethod
    def read_config(
        cls,
        model: Type[T] = AppConfig,
        filename: str = 'settings.ini',
        default_section: str = 'config'
    ) -> T:
        parser = cls(default_section=default_section)
        parser.read(filename)

        data = {
            cls.camel_to_snake(key): value for key, value in parser.defaults().items()
        }

        return model(**data)
