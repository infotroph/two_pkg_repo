
PKGS = p1 p2

PKG_CHECK := $(PKGS:%=.check/%)
PKG_COVR := $(PKGS:%=.coverage/%)

.PHONY: check coverage clean
check: $(PKG_CHECK) | .check/devtools
coverage: $(PKG_COVR) | .coverage/covr
clean:
	rm -rf .check .coverage

check_R_pkg = Rscript -e "devtools::check('"$(strip $(1))"')"
covr_R_pkg = Rscript -e "covr::codecov('"$(strip $(1))"')"
# covr_R_pkg = Rscript -e "covr::package_coverage('"$(strip $(1))"')"

.check .coverage:
	mkdir -p $@

.check/devtools:
	time Rscript -e "if(!require('devtools', quietly = TRUE)) install.packages('devtools', repos = 'http://cran.rstudio.com')" > $@	
.check/roxygen2:
	time Rscript -e "if(!require('roxygen2', quietly = TRUE)) install.packages('roxygen2', repos = 'http://cran.rstudio.com')" > $@
.coverage/covr:
	time Rscript -e "if(!require('covr', quietly = TRUE)) install.packages('covr', repos = 'http://cran.rstudio.com')" > $@


.SECONDEXPANSION:

.check/%: $$(wildcard %/*) | $$(@D)
	$(call check_R_pkg, $(subst .check/,,$@)) > $@

.coverage/%: $$(wildcard %/*) | $$(@D)
	$(call covr_R_pkg, $(subst .coverage/,,$@)) > $@