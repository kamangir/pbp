import os
from typing import List
from pbp import NAME, VERSION, DESCRIPTION
from pbp.logger import logger
from abcli import file
from abcli import string

NAME = f"{NAME}.digest"


def digest(
    digest_filename: str,
    source_path: str,
    destination_filename: str,
) -> bool:
    logger.info(f"digest: {source_path} -> {destination_filename}")

    success, digest_list = file.load_yaml(digest_filename)
    if not success:
        return success

    digest_text: List[str] = [
        "#! /usr/bin/env bash",
        "# source: Pro Bash Programming: Scripting the GNU/Linux Shell",
        "# https://cfajohnson.com/books/cfajohnson/pbp/",
        "",
        f"# digested by {NAME}.{VERSION}",
        f"# {DESCRIPTION}",
        f"# {string.pretty_date()}",
    ]

    for item in digest_list:
        success, content = file.load_text(os.path.join(source_path, item["filename"]))
        if not success:
            return False

        logger.info(f"+= {item['filename']}")

        digest_text += [
            "",
            "# {}::{}:{}".format(
                item["filename"],
                item["start"],
                item["end"],
            ),
        ] + content[item["start"] : item["end"]]

    return file.save_text(destination_filename, digest_text)
