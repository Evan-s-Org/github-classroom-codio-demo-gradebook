import unittest

from gradebook import calculate_average, letter_grade, is_passing


class TestCalculateAverage(unittest.TestCase):
    def test_average_whole_number_result(self):
        self.assertEqual(calculate_average([90, 80, 70]), 80.0)

    def test_average_decimal_result(self):
        self.assertAlmostEqual(calculate_average([100, 95, 91]), 95.3333333333)


class TestLetterGrade(unittest.TestCase):
    def test_letter_grade_typical_scores(self):
        self.assertEqual(letter_grade(95), "A")
        self.assertEqual(letter_grade(85), "B")
        self.assertEqual(letter_grade(75), "C")
        self.assertEqual(letter_grade(65), "D")
        self.assertEqual(letter_grade(50), "F")

    def test_letter_grade_boundaries(self):
        self.assertEqual(letter_grade(90), "A")
        self.assertEqual(letter_grade(80), "B")
        self.assertEqual(letter_grade(70), "C")
        self.assertEqual(letter_grade(60), "D")


class TestIsPassing(unittest.TestCase):
    def test_passing_scores(self):
        self.assertTrue(is_passing(100))
        self.assertTrue(is_passing(60))

    def test_failing_scores(self):
        self.assertFalse(is_passing(59))
        self.assertFalse(is_passing(0))


if __name__ == "__main__":
    unittest.main()
