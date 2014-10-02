library(testCoverage)

# If use 'RUnit' for testing
message("Running RUnit unit tests...")
selfTest(testtype = "RUnit")

# If use 'testthat' for testing
message("Running testthat unit tests...")
selfTest(testtype = "testthat")

