import argparse
from pbp import NAME, VERSION, DESCRIPTION
from pbp.digest import digest
from pbp.logger import logger

parser = argparse.ArgumentParser(NAME, description=f"{NAME}-{VERSION}")
parser.add_argument(
    "task",
    type=str,
    help="digest|version",
)
parser.add_argument(
    "--show_description",
    type=bool,
    default=0,
    help="0|1",
)
parser.add_argument(
    "--source_path",
    type=str,
    default="",
)
parser.add_argument(
    "--destination_filename",
    type=str,
    default="",
)
parser.add_argument(
    "--digest_filename",
    type=str,
    default="",
)
args = parser.parse_args()

success = False
if args.task == "digest":
    success = digest(
        args.digest_filename,
        args.source_path,
        args.destination_filename,
    )
elif args.task == "version":
    print(
        "{}-{}{}".format(
            NAME,
            VERSION,
            "\\n{}".format(DESCRIPTION) if args.show_description else "",
        )
    )
    success = True
else:
    logger.error(f"-{NAME}: {args.task}: command not found.")

if not success:
    logger.error(f"-{NAME}: {args.task}: failed.")
