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


# freeze code begin
def main():
    scores_text = input()
    scores = [float(score.strip()) for score in scores_text.split(",")]

    average = calculate_average(scores)

    print(f"Class average: {average:.2f}")

    for score in scores:
        print(f"{score:.0f}: {letter_grade(score)}, passing: {is_passing(score)}")


if __name__ == "__main__":
    main()
# freeze code end
