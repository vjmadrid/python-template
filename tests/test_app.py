from .context import projectx


def test_app(capsys, example_fixture):
    # pylint: disable=W0612,W0613
    projectx.Example.run()
    captured = capsys.readouterr()

    assert "Hello World..." in captured.out
