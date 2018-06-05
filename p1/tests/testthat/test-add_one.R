
context("adding one")

test_that("numeric only", {
	expect_equal(add_one(2), 3)
	expect_error(add_one("2"))
})
