# Gradebook Functions

This is a short Python assignment designed for a GitHub Classroom or Codio autograding demo.

Students will complete three functions in `gradebook.py`:

1. `calculate_average(scores)`
2. `letter_grade(score)`
3. `is_passing(score)`

The visible tests are in `tests/test_gradebook.py`. To run them locally or inside a Codio container:

```bash
python3 -m unittest discover -s tests -p "test_*.py" -v
```

Or use the helper script:

```bash
bash run_tests.sh
```

## Expected behavior

### `calculate_average(scores)`

Return the arithmetic mean of a non-empty list of numeric scores.

```python
calculate_average([90, 80, 70])  # returns 80.0
```

### `letter_grade(score)`

Return a letter grade using this scale:

| Score | Letter |
|---:|:---|
| 90 and above | A |
| 80 through 89 | B |
| 70 through 79 | C |
| 60 through 69 | D |
| below 60 | F |

### `is_passing(score)`

Return `True` when the score is 60 or above. Return `False` otherwise.

## Notes for students

- Do not change the names of the functions.
- Do not change the visible tests unless your instructor tells you to.
- Commit and push your work after each meaningful change.
