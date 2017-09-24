from fac import fac
import pytest


def test_zero():
    assert fac(0) == 1


test_data = [(1, 1), (2, 2), (3, 6), (4, 24), (5, 120), (10, 3628800)]

@pytest.mark.parametrize(('input', 'result'), test_data)
def test_positive_integer(input, result):
    assert fac(input) == result


test_data = [-1, 3.0, '5']

@pytest.mark.parametrize(('input'), test_data)
def test_invalid(input):
    with pytest.raises(ValueError):
        fac(input)
