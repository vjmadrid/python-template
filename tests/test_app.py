from .context import acme


def test_app(capsys, ex_fixture):
    # pylint: disable=W0612,W0613
    acme.Example.run()
    captured = capsys.readouterr()

    assert "Hello World..." in captured.out
