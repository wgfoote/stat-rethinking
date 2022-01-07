setwd("/workspace/stat_rethinking_2022")
setHook("rstudio.sessionInit", function(newSession) {
  if (newSession && is.null(rstudioapi::getActiveProject()))
    rstudioapi::openProject("/workspace/stat_rethinking_2022/")
}, action = "append")