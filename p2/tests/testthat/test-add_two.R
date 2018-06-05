
context("adding two")

test_that("numeric only", {
	expect_equal(add_two(2), 4)
	expect_error(add_two("2"))
})
