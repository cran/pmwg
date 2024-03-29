## -----------------------------------------------------------------------------
library(pmwg)

head(forstmann)

## -----------------------------------------------------------------------------
lba_loglike <- function(x, data) {
  x <- exp(x)
  if (any(data$rt < x["t0"])) {
    return(-1e10)
  }
  # This is faster than "paste".
  bs <- x["A"] + x[c("b1", "b2", "b3")][data$condition]

  out <- rtdists::dLBA(
    rt = data$rt, # nolint
    response = data$stim,
    A = x["A"],
    b = bs,
    t0 = x["t0"],
    mean_v = x[c("v1", "v2")],
    sd_v = c(1, 1),
    distribution = "norm",
    silent = TRUE
  )
  bad <- (out < 1e-10) | (!is.finite(out))
  out[bad] <- 1e-10
  out <- sum(log(out))
  out
}

## -----------------------------------------------------------------------------
pars <- c("b1", "b2", "b3", "A", "v1", "v2", "t0")

priors <- list(
  theta_mu_mean = rep(0, length(pars)),
  theta_mu_var = diag(rep(1, length(pars)))
)

## -----------------------------------------------------------------------------
# Create the Particle Metropolis within Gibbs sampler object
sampler <- pmwgs(
  data = forstmann,
  pars = pars,
  ll_func = lba_loglike,
  prior = priors
)

## ---- eval = FALSE------------------------------------------------------------
#  # Initialise (generate first random effects for sampler)
#  sampler <- init(sampler)  # Can also pass start points for sampler
#  
#  # Run each stage of the sampler, can adjust number of particles on each
#  sampler <- run_stage(sampler, stage = "burn")
#  sampler <- run_stage(sampler, stage = "adapt")
#  sampler <- run_stage(sampler, stage = "sample")

