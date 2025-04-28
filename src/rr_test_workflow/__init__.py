"""Test GitHub workflows, actions and more."""


from . import __about__

__version__ = __about__.__version__
__version_tuple__ = __about__.__version_tuple__

def main() -> None:
	"""Say 'Hi'."""
	print("Hello from test-workflow!")
