import unittest

class NumbersTest(unittest.TestCase):

    def test_equal(self):
        self.assertEqual(1 + 1, 1)
        return None

if __name__ == '__main__':
    unittest.main()
