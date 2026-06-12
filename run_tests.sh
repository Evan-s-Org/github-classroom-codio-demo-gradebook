#!/usr/bin/env bash
set -uo pipefail

python3 - <<'PY'
import contextlib
import io
import sys
import traceback
import unittest

TEST_DIR = "tests"
TEST_PATTERN = "test_*.py"


class CleanResult(unittest.TestResult):
    def __init__(self):
        super().__init__()
        self.rows = []
        self.details = []
        self._stdout = None
        self._stderr = None
        self._stdout_cm = None
        self._stderr_cm = None

    def startTest(self, test):
        super().startTest(test)
        self._stdout = io.StringIO()
        self._stderr = io.StringIO()
        self._stdout_cm = contextlib.redirect_stdout(self._stdout)
        self._stderr_cm = contextlib.redirect_stderr(self._stderr)
        self._stdout_cm.__enter__()
        self._stderr_cm.__enter__()

    def stopTest(self, test):
        self._stderr_cm.__exit__(None, None, None)
        self._stdout_cm.__exit__(None, None, None)
        super().stopTest(test)

    def addSuccess(self, test):
        super().addSuccess(test)
        self.rows.append((test.id(), "PASS", ""))

    def addFailure(self, test, err):
        super().addFailure(test, err)
        message = self._format_error(err)
        self.rows.append((test.id(), "FAIL", self._short_message(message)))
        self.details.append((test.id(), "FAIL", message))

    def addError(self, test, err):
        super().addError(test, err)
        message = self._format_error(err)
        self.rows.append((test.id(), "ERROR", self._short_message(message)))
        self.details.append((test.id(), "ERROR", message))

    def addSkip(self, test, reason):
        super().addSkip(test, reason)
        self.rows.append((test.id(), "SKIP", reason))

    def _format_error(self, err):
        return "".join(traceback.format_exception(*err)).strip()

    def _short_message(self, message):
        lines = [line.strip() for line in message.splitlines() if line.strip()]

        for line in reversed(lines):
            if line.startswith("AssertionError:"):
                return line

        return lines[-1] if lines else ""


def line():
    print("=" * 78)


def section(title):
    print()
    line()
    print(title)
    line()


def truncate(text, width):
    text = str(text)
    if len(text) <= width:
        return text
    return text[: width - 3] + "..."


try:
    suite = unittest.defaultTestLoader.discover(TEST_DIR, pattern=TEST_PATTERN)
except Exception:
    section("Gradebook Unit Test Report")
    print("Result    : ERROR")
    print()
    print("The test suite could not be discovered.")
    print()
    traceback.print_exc()
    sys.exit(1)

result = CleanResult()
suite.run(result)

total = result.testsRun
failed = len(result.failures)
errors = len(result.errors)
skipped = len(result.skipped)
passed = total - failed - errors - skipped
success = result.wasSuccessful()

section("Gradebook Unit Test Report")

print(f"Tests run : {total}")
print(f"Passed    : {passed}")
print(f"Failed    : {failed}")
print(f"Errors    : {errors}")
print(f"Skipped   : {skipped}")
print(f"Result    : {'PASS' if success else 'FAIL'}")

section("Test Results")

status_width = 8
test_width = 58

print(f"{'Status':<{status_width}}  {'Test':<{test_width}}  Message")
print(f"{'-' * status_width}  {'-' * test_width}  {'-' * 40}")

for test_id, status, message in result.rows:
    print(
        f"{status:<{status_width}}  "
        f"{truncate(test_id, test_width):<{test_width}}  "
        f"{truncate(message, 80)}"
    )

if result.details:
    section("Failure Details")

    for index, (test_id, status, message) in enumerate(result.details, start=1):
        lines = message.splitlines()

        file_line = ""
        assertion_line = ""
        error_line = ""

        for i, line_text in enumerate(lines):
            stripped = line_text.strip()

            if "/home/codio/workspace/tests/" in stripped and ", line " in stripped:
                file_line = stripped

                if i + 1 < len(lines):
                    next_line = lines[i + 1].strip()
                    if next_line:
                        assertion_line = next_line

            if stripped.startswith("AssertionError:"):
                error_line = stripped

        print(f"[{index}] {status}: {test_id}")
        print("-" * 78)

        if file_line:
            print(file_line)

        if assertion_line:
            print(f"Check: {assertion_line}")

        if error_line:
            print(f"Message: {error_line}")
        else:
            print(message)

        print()

section("Next Step")

if success:
    print("All visible tests passed.")
else:
    print("Review the failure details above.")
    print("Update gradebook.py.")
    print("Run the tests again with: bash run_tests.sh")

line()

sys.exit(0 if success else 1)
PY
