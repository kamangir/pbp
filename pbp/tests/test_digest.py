import os
from pbp.digest import digest
from abcli.modules import objects
from abcli import file


def test_digest():
    destination_filename = objects.path_of(
        "test.sh",
        objects.unique_object(),
    )

    pbp_git_path = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))

    assert digest(
        digest_filename=os.path.join(pbp_git_path, "assets/digest.yaml"),
        source_path=pbp_git_path,
        destination_filename=destination_filename,
    )

    assert file.exist(destination_filename)
