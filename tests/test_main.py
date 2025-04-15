"""Test main.py."""

from test_workflow.main import main


def test_main():
	"""Test main()."""
	assert main() == 4  # noqa: PLR2004
