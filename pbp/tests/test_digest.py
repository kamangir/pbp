import os
from pbp.digest import digest
from abcli import env
from abcli.modules import objects
from abcli import file


def test_digest():
    destination_filename = objects.path_of(
        "test.sh",
        objects.unique_object(),
    )

    assert digest(
        digest_filename=os.path.join(
            env.abcli_path_git,
            "pbp/assets/digest.yaml",
        ),
        source_path=os.path.join(
            env.abcli_path_git,
            "pbp",
        ),
        destination_filename=destination_filename,
    )

    assert file.exist(destination_filename)
