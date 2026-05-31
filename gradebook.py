"""
Gradebook Functions

Complete the functions below. The visible tests are in tests/test_gradebook.py.
Run them with:

    python3 -m unittest discover -s tests -p "test_*.py" -v
"""


def calculate_average(scores):
    """Return the arithmetic mean of a non-empty list of numeric scores."""
    # TODO: This currently uses integer division, which loses the decimal part.
    return sum(scores) // len(scores)


def letter_grade(score):
    """Return A, B, C, D, or F based on a numeric score."""
    # TODO: Check the boundary values carefully.
    if score > 90:
        return "A"
    if score > 80:
        return "B"
    if score > 70:
        return "C"
    if score > 60:
        return "D"
    return "F"


def is_passing(score):
    """Return True if the score is passing, otherwise False."""
    # TODO: A score of exactly 60 should count as passing.
    return score > 60
