library(testCoverage)

# If use 'RUnit' for testing
message("Running RUnit unit tests...")
selfCoverage(testtype = "RUnit")

# If use 'testthat' for testing
message("Running testthat unit tests...")
selfCoverage(testtype = "testthat")

